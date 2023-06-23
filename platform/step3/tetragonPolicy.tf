
resource "kubernetes_manifest" "tetragonPolicy" {
  count = var.createPolicy ? 1 : 0
  manifest = {
    "apiVersion" = "cilium.io/v1alpha1"
    "kind" = "TracingPolicy"
    "metadata" = {
      "name" = "haproxy"
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
              "matchArgs" = [
                {
                  "index" = 1
                  "operator" = "Postfix"
                  "values" = [
                    "/haproxy.cfg",
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