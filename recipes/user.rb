#
# Cookbook Name:: apps
# Recipe:: user
#
# Copyright 2012, getaroom
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

search :apps do |app|
  if (app['server_roles'] & node.run_list.roles).any?
    users_query = ["(groups:#{app['group']} AND NOT action:remove)", node['apps']['user_search_qualifier']].compact.join(" AND ")
    users = search(:users, users_query)

    group app['group'] do
      system true
      members users.map { |user| user['id'] }
    end

    user app['owner'] do
      group app['group']
      system true
      home app['deploy_to']
      shell app['shell']
      supports :manage_home => true
    end

    directory "#{app['deploy_to']}/.ssh" do
      owner app['owner']
      group app['group']
      mode "700"
    end

    file "#{app['deploy_to']}/.ssh/authorized_keys" do
      owner app['owner']
      group app['group']
      mode "600"
      content users.map { |user| user['ssh_keys'] }.flatten.sort.join("\n")
    end
  end
end
