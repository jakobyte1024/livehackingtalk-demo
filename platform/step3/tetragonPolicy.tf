
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
              "type" = "int"
            },
            {
              "index" = 1
              "type" = "file"
            },
          ]
          "call" = "fd_install"
          "return" = false
          "selectors" = [
            {
              "matchActions" = [
                {
                  "action" = "Sigkill"
                },
              ]
              "matchBinaries" = [
                {
                  "operator" = "In"
                  "values" = [
                    "/usr/bin/tcpdump",
                  ]
                },
              ]
            },
          ]
          "syscall" = false
        },
      ]
    }
  }
}