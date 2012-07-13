describe_recipe "apps::users" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "www app" do
    it "www user exists" do
      user("www").must_exist
    end

    it "www user is in the www group" do
      assert_equal group("www").gid, user("www").gid
    end
  end
end
