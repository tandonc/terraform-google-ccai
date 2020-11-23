variable "project_id" {
  type = string
}

variable "regions" {
  type = list(string)
}

variable "env" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "service_name" {
  type = string
  default = "fulfillment-controller"
}

variable "port" {
  type = number
  default = 5000
}

variable "domains" {
  type = list(string)
}

variable "gcr_hostname" {
  type = string
  default = "us.gcr.io"
}

variable "github_org" {
  type = string
  default = "taosmountain"
}

variable "github_repo" {
  type = string
  default = "fulfillment-controller"
}

variable "github_branch" {
  type = string
  default = ".*"
}

variable "trigger_description" {
  type = string
  default = "Build and deploy fulfillment-controller to Cloud Run"
}

variable "log" {
  type = bool
  default = true
}

variable "sample_rate" {
  type = number
  default = 1.0
}
