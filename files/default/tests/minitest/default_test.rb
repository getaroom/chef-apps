describe_recipe "apps::default" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  it "the framework_environtment attribute defaults to the chef_environment" do
    assert_equal node.chef_environment, node['framework_environment']
  end
end
