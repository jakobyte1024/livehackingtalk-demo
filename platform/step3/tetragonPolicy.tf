
resource "kubernetes_manifest" "tetragonPolicy" {
  count = var.createPolicy ? 1 : 0
  manifest = {
    "apiVersion" = "cilium.io/v1alpha1"
    "kind" = "TracingPolicy"
    "metadata" = {
      "name" = "tcpdump-blocking"
    }
    "spec" = {
      "kprobes" = [
        {
          "args" = [
            {
              "index" = 0
              "type" = "string"
            },
          ]
          "call" = "sys_execve"
          "selectors" = [
            {
              "matchActions" = [
                {
                  "action" = "Sigkill"
                },
              ]
              "matchArgs" = [
                {
                  "index" = 0
                  "operator" = "Prefix"
                  "values" = [
                    "/usr/bin/tcpdump",
                  ]
                },
              ]
            },
          ]
          "syscall" = true
        },
      ]
    }
  }
}