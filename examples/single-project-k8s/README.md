# Sysdig Secure for Cloud in GCP :: Single-Account on Kubernetes Cluster

Deploy Sysdig Secure for Cloud in a provided existing Kubernetes Cluster.

- Sysdig **Helm** charts will be used to deploy the secure-for-cloud stack:
    - [Cloud-Connector Chart](https://charts.sysdig.com/charts/cloud-connector/)
    - Because these charts require specific GCP credentials to be passed by parameter, a new service account + key will
      be created within the project. See [`credentials.tf`](./credentials.tf)
- Used architecture is similar to [single-project](../single-project) but changing Cloud Run <---> with an existing K8s

All the required resources and workloads will be run under the same GCP project.

## Prerequisites

Minimum requirements:

1. `gcloud` credentials configuration
2. A Kubernetes cluster configured within your `~/.kube/config`
3. Secure requirements, as input variable value
    ```
    sysdig_secure_api_token=<SECURE_API_TOKEN>
    ```

## Usage

For quick testing, use this snippet on your terraform files

```terraform
module "secure_for_cloud_gcp_single_project_k8s" {
  source = "sysdiglabs/secure-for-cloud/google//examples/single-project-k8s"

  project_id              = "your-project-id"
  sysdig_secure_api_token = "00000000-1111-2222-3333-444444444444"
}
```

See [inputs summary](#inputs) or module module [`variables.tf`](./variables.tf) file for more optional configuration.

Notice that:

* This example will create resources that **cost money**. Run `terraform destroy` when you don't need them anymore.
* All created resources will be created within the tags `product:sysdig-secure-for-cloud`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.67.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.3.0 |
| <a name="requirement_sysdig"></a> [sysdig](#requirement\_sysdig) | >= 0.5.19 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3.67.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_connector_project_sink"></a> [connector\_project\_sink](#module\_connector\_project\_sink) | ../../modules/infrastructure/project_sink |  |

## Resources

| Name | Type |
|------|------|
| [google_pubsub_subscription.subscription](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_subscription_iam_member.pull](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription_iam_member) | resource |
| [google_service_account.connector_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.connector_sa_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [helm_release.cloud_connector](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID where the secure-for-cloud workload is going to be deployed | `string` | n/a | yes |
| <a name="input_sysdig_secure_api_token"></a> [sysdig\_secure\_api\_token](#input\_sysdig\_secure\_api\_token) | Sysdig's Secure API Token | `string` | n/a | yes |
| <a name="input_cloud_connector_image"></a> [cloud\_connector\_image](#input\_cloud\_connector\_image) | Cloud-connector image to deploy | `string` | `"quay.io/sysdig/cloud-connector"` | no |
| <a name="input_location"></a> [location](#input\_location) | Zone where the stack will be deployed | `string` | `"us-central1"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"sfc"` | no |
| <a name="input_sysdig_secure_endpoint"></a> [sysdig\_secure\_endpoint](#input\_sysdig\_secure\_endpoint) | Sysdig Secure API endpoint | `string` | `"https://secure.sysdig.com"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module is maintained and supported by [Sysdig](https://sysdig.com).

## License

Apache 2 Licensed. See LICENSE for full details.