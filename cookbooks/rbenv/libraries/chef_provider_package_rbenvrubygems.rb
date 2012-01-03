#
# Cookbook Name:: rbenv
# Provider:: Chef::Provider::Package::RbenvRubygems
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright 2011, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Chef
  class Provider
    class Package
      class RbenvRubygems < Chef::Provider::Package::Rubygems

        class RbenvGemEnvironment < AlternateGemEnvironment
          attr_reader :rbenv_version, :rbenv_user

          include Chef::Rbenv::Mixin::ShellOut

          def initialize(gem_binary_location, rbenv_version, rbenv_user = nil)
            super(gem_binary_location)
            @rbenv_version = rbenv_version
            @rbenv_user = rbenv_user
          end
        end

        attr_reader :rbenv_user

        include Chef::Rbenv::Mixin::ShellOut
        include Chef::Rbenv::ScriptHelpers

        def initialize(new_resource, run_context=nil)
          super
          normalize_version
          @new_resource.gem_binary(wrap_shim_cmd("gem"))
          @rbenv_user = new_resource.respond_to?("user") ? new_resource.user : nil
          @gem_env = RbenvGemEnvironment.new(
            gem_binary_path, new_resource.rbenv_version, rbenv_user)
        end

        def install_package(name, version)
          super
          rbenv_rehash new_resource do
            action :nothing
          end.run_action(:run)
          true
        end

        def remove_package(name, version)
          super
          rbenv_rehash new_resource do
            action :nothing
          end.run_action(:run)
          true
        end

        private

        def normalize_version
          if @new_resource.rbenv_version == "global"
            @new_resource.rbenv_version(current_global_version)
          end
        end
      end
    end
  end
end
