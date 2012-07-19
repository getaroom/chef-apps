describe_recipe "apps::deploy_key" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "www app" do
    describe "deploy key" do
      let(:key) { file "/srv/www/.ssh/id_rsa" }
      let(:stat) { File.stat(key.path) }

      it "exists" do
        key.must_exist
      end

      it "is owned by www/www" do
        assert_equal user("www").uid, stat.uid
        assert_equal group("www").gid, stat.gid
      end

      it "is mode 600" do
        assert_equal "600".oct, (stat.mode & 007777)
      end

      it "includes the app's deploy key" do
        key.must_include "-----BEGIN RSA PRIVATE KEY-----\nxxxx\n-----END RSA PRIVATE KEY-----"
      end
    end
  end

  describe "princess app" do
    it "does not have a deploy key" do
      file("/srv/princess/.ssh/id_rsa").wont_exist
    end
  end
end
