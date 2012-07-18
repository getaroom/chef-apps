describe_recipe "apps::user" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "www app" do
    let(:www_group) { group "www" }
    let(:www_user) { user "www" }

    describe "www group" do
      it "exists" do
        www_group.must_exist
      end

      it "is a system group" do
        assert_operator www_group.gid, :<, 1000
      end

      it "includes the users data bag users" do
        www_group.must_include "janedoe"
        www_group.must_include "johndoe"
      end

      it "does not include the removed data bag users" do
        www_group.wont_include "bofh"
      end
    end

    describe "www user" do
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

    describe ".ssh directory" do
      let(:ssh_dir) { directory "/srv/www/.ssh" }

      it "exists" do
        ssh_dir.must_exist
      end

      it "is owned by www/www" do
        ssh_dir.must_have :owner, "www"
        ssh_dir.must_have :group, "www"
      end

      it "is mode 700" do
        ssh_dir.must_have :mode, "700"
      end
    end

    describe "authorized_keys file" do
      let(:authorized_keys) { file "/srv/www/.ssh/authorized_keys" }
      let(:stat) { File.stat(authorized_keys.path) }

      it "exists" do
        authorized_keys.must_exist
      end

      it "is owned by www/www" do
        assert_equal www_user.uid, stat.uid
        assert_equal www_group.gid, stat.gid
      end

      it "is mode 600" do
        assert_equal "600".oct, (stat.mode & 007777)
      end

      it "includes a user's single public key" do
        authorized_keys.must_include "ssh-rsa AAAAB3Nz...yhCw== johndoe"
      end

      it "includes a user's multiple public keys" do
        authorized_keys.must_include "ssh-rsa AAAAB3Nz...yhCw== janedoe1"
        authorized_keys.must_include "ssh-rsa AAAAB3Nz...yhCw== janedoe2"
      end

      it "does not include a removed user's public key" do
        authorized_keys.wont_include "ssh-rsa AAAAB3Nz...yhCw== bofh"
      end
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
