# <a name="description"></a> Description

Manages the [ruby-build][rb_site] framework and its installed Rubies.
A lightweight resources and providers ([LWRP][lwrp]) is also defined.

# <a name="requirements"></a> Requirements

## <a name="requirements-chef"></a> Chef

Tested on 0.10.4 but newer and older version should work just
fine. File an [issue][issues] if this isn't the case.

## <a name="requirements-platform"></a> Platform

The following platforms have been tested with this cookbook, meaning that
the recipes and LWRPs run on these platforms without error:

* ubuntu (10.04)

Please [report][issues] any additional platforms so they can be added.

## <a name="requirements-cookbooks"></a> Cookbooks

There are **no** external cookbook dependencies. However, if you are
installing [JRuby][jruby] then a Java runtime will need to be installed.
The Opscode [java cookbook][java_cb] can be used on supported platforms.

# <a name="installation"></a> Installation

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release
is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

## <a name="installation-platform"></a> From the Opscode Community Platform

To install this cookbook from the Opscode platform, use the *knife* command:

    knife cookbook site install ruby_build

## <a name="installation-librarian"></a> Using Librarian

The [Librarian][librarian] gem aims to be Bundler for your Chef cookbooks.
Include a reference to the cookbook in a [Cheffile][cheffile] and run
`librarian-chef install`. To install with Librarian:

    gem install librarian
    cd chef-repo
    librarian-chef init
    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'ruby_build',
      :git => 'git://github.com/fnichol/chef-ruby_build.git', :ref => 'v0.6.0'
    END_OF_CHEFFILE
    librarian-chef install

## <a name="installation-kgc"></a> Using knife-github-cookbooks

The [knife-github-cookbooks][kgc] gem is a plugin for *knife* that supports
installing cookbooks directly from a GitHub repository. To install with the
plugin:

    gem install knife-github-cookbooks
    cd chef-repo
    knife cookbook github install fnichol/chef-ruby_build/v0.6.0

## <a name="installation-gitsubmodule"></a> As a Git Submodule

A common practice (which is getting dated) is to add cookbooks as Git
submodules. This is accomplishes like so:

    cd chef-repo
    git submodule add git://github.com/fnichol/chef-ruby_build.git cookbooks/ruby_build
    git submodule init && git submodule update

**Note:** the head of development will be linked here, not a tagged release.

## <a name="installation-tarball"></a> As a Tarball

If the cookbook needs to downloaded temporarily just to be uploaded to a Chef
Server or Opscode Hosted Chef, then a tarball installation might fit the bill:

    cd chef-repo/cookbooks
    curl -Ls https://github.com/fnichol/chef-ruby_build/tarball/v0.6.0 | tar xfz - && \
      mv fnichol-chef-ruby_build-* ruby_build

# <a name="usage"></a> Usage

Simply include `recipe[ruby_build]` in your run\_list to have ruby-build
installed. You will also have access to the `ruby_build_ruby` resource. See
the [Resources and Providers](#lwrps) section for more details.

# <a name="recipes"></a> Recipes

## <a name="recipes-default"></a> default

Installs the ruby-build codebase and initializes Chef to use the Lightweight
Resources and Providers ([LWRPs][lwrp]).

# <a name="attributes"></a> Attributes

## <a name="attributes-git-url"></a> git\_url

The Git URL which is used to install ruby-build.

The default is `"git://github.com/sstephenson/ruby-build.git"`.

## <a name="attributes-git-ref"></a> git\_ref

A specific Git branch/tag/reference to use when installing ruby-build. For
example, to pin ruby-build to a specific release:

    node['ruby_build']['git_ref'] = "v20111030"

The default is `"master"`.

## <a name="attributes-default-ruby-base-path"></a> default\_ruby_base\_path

The default base path for a system-wide installed Ruby. For example, the
following resource:

    ruby_build_ruby "1.9.3-p0"

will be installed into
`"#{node['ruby_build']['default_ruby_base_path']}/1.9.3-p0"` unless a
`prefix_path` attribute is explicitly set.

The default is `"/usr/local/ruby"`.

## <a name="attributes-upgrade"></a> upgrade

Determines how to handle installing updates to the ruby-build framework.
There are currently 2 valid values:

* `"none"`, `false`, or `nil`: will not update ruby-build and leave it in its
  current state.
* `"sync"` or `true`: updates ruby-build to the version specified by the
  `git_ref` attribute or the head of the master branch by default.

The default is `"none"`.

# <a name="lwrps"></a> Resources and Providers

## <a name="lwrps-rbr"></a> ruby\_build\_ruby

### <a name="lwrps-rbr-actions"></a> Actions

Action    |Description                   |Default
----------|------------------------------|-------
install   |Build and install a Ruby from a definition file. See the ruby-build [readme][rb_readme] for more details. |Yes
reinstall |Force a recompiliation of the Ruby from source. The :install action will skip a build if the target install directory already exists. |

### <a name="lwrps-rbr-attributes"></a> Attributes

Attribute   |Description |Default value
-------------|------------|-------------
definition   |**Name attribute:** the name of a [built-in definition][rb_definitions] or the path to a ruby-build definition file. |`nil`
prefix\_path |The path to which the Ruby will be installed. |`nil`
user         |A user which will own the installed Ruby. The default value of `nil` denotes a system-wide Ruby (root-owned) is being targeted. **Note:** if specified, the user must already exist. |`nil`
group        |A group which will own the installed Ruby. The default value of `nil` denotes a system-wide Ruby (root-owned) is being targeted. **Note:** if specified, the group must already exist. |`nil`

### <a name="lwrps-rbr-examples"></a> Examples

#### Install Ruby

    ruby_build_ruby "1.9.3-p0" do
      prefix_path "/usr/local/ruby/ruby-1.9.3-p0"

      action      :install
    end

    ruby_build_ruby "jruby-1.6.5"

**Note:** the install action is default, so the second example is more common.

#### Install A Ruby For A User

    ruby_build_ruby "maglev-1.0.0" do
      prefix_path "/home/deploy/.rubies/maglev-1.0.0"
      user        "deploy"
      group       "deploy"
    end

#### Reinstall Ruby

    ruby_build_ruby "rbx-1.2.4" do
      prefix_path "/opt/rbx-1.2.4"

      action      :reinstall
    end

**Note:** the Ruby will be built whether or not the Ruby exists in the
`prefix_path` directory.

# <a name="development"></a> Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

# <a name="license"></a> License and Author

Author:: Fletcher Nichol (<fnichol@nichol.ca>)

Copyright 2011, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[chef_repo]:      https://github.com/opscode/chef-repo
[cheffile]:       https://github.com/applicationsonline/librarian/blob/master/lib/librarian/chef/templates/Cheffile
[java_cb]:        http://community.opscode.com/cookbooks/java
[jruby]:          http://jruby.org/
[kgc]:            https://github.com/websterclay/knife-github-cookbooks#readme
[librarian]:      https://github.com/applicationsonline/librarian#readme
[lwrp]:           http://wiki.opscode.com/display/chef/Lightweight+Resources+and+Providers+%28LWRP%29
[rb-readme]:      https://github.com/sstephenson/ruby-build#readme
[rb-site]:        https://github.com/sstephenson/ruby-build
[rb-definitions]: https://github.com/sstephenson/ruby-build/tree/master/share/ruby-build

[repo]:         https://github.com/fnichol/chef-ruby_build
[issues]:       https://github.com/fnichol/chef-ruby_build/issues
