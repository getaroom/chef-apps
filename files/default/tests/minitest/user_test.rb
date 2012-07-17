describe_recipe "apps::user" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "www app" do
    describe "www group" do
      let(:www_group) { group "www" }

      it "exists" do
        www_group.must_exist
      end

      it "is a system group" do
        assert_operator www_group.gid, :<, 1000
      end
    end

    describe "www user" do
      let(:www_user) { user "www" }

      it "exists" do
        www_user.must_exist
      end

      it "is in the www group" do
        assert_equal group("www").gid, www_user.gid
      end

      it "is a system user" do
        assert_operator www_user.uid, :<, 1000
      end

      it "uses the deploy_to directory as its home directory" do
        www_user.must_have :home, "/srv/www"
      end
    end

    describe "www home directory" do
      let(:home) { directory "/srv/www" }

      it "exists" do
        home.must_exist
      end

      it "is owned by www/www" do
        home.must_have :owner, "www"
        home.must_have :group, "www"
      end
    end

  describe "princess app" do
    describe "princess group" do
      it "does not exist" do
        group("princess").wont_exist
      end
    end

    describe "princess user" do
      it "does not exist" do
        user("princess").wont_exist
      end
    end

    describe "princess home directory" do
      it "does not exist" do
        directory("/srv/princess").wont_exist
      end
    end
  end
end
