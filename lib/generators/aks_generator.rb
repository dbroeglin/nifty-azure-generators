class AksGenerator < Rails::Generators::Base
  desc "This generator creates a bash file for creating an Azure Kubernetes Service"

  class_option :environment, 
    type: :string, 
    required: true,
    default: "production", 
    desc: "Environment to deploy to (production, test, development, etc.)"
  class_option :workload, 
    type: :string, 
    required: true,
    default: "workload", 
    desc: "Name of the workload to deploy"


  def create_bash_file
    @environment = options["environment"]
    @workload = options["workload"]

    resource_group_name = "rg-#{@workload}-#{@environment}-001"

    create_file "iac/aks.sh", <<~RUBY
      #!/bin/bash
      # Add initialization content here

      az aks create --resource-group #{resource_group_name} --name myAKSCluster --node-count 1 --enable-addons monitoring --generate-ssh-keys
    RUBY
  end
end