class NcpIamAuthenticator < Formula
  desc "NaverCloudPlatform Kubernetes Service Authenticator CLI for IAM Authentication"
  homepage "https://github.com/NaverCloudPlatform/ncp-iam-authenticator"
  url "https://github.com/NaverCloudPlatform/ncp-iam-authenticator.git",
      tag:      "v1.1.1",
      revision: "ed1936e6d15703c0f5b3d7d8e56b0660e0c22da0"
  license "Apache-2.0"
  head "https://github.com/NaverCloudPlatform/ncp-iam-authenticator.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    ldflags = ["-s", "-w",
               "-X github.com/NaverCloudPlatform/ncp-iam-authenticator/cmd.version=#{version}"]
    system "go", "build", *std_go_args(ldflags: ldflags), "./main.go"
    prefix.install_metafiles
  end

  test do
    output = shell_output("#{bin}/ncp-iam-authenticator version")
    assert_match %Q("v#{version}"), output
  end
end
