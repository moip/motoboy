class RPM_S3_1_0_0 < FPM::Cookery::Recipe
  name          'rpm-s3'
  version       '1.0.0'
  revision      0
  description   'Reads SQS queues to grab rpms from S3 and build/append a new repodata to the bucket, turning into a yum repo.'
  homepage      'https://github.com/moip/rpm-s3'
  section       'admin'

  source        "https://s3.amazonaws.com/rpm-s3/rpm-s3-#{version}.tar.gz"
  sha256        "6a25a18e838656e727e5fc55582bd62d1ff08390c088cc2ee6fc25aee2c122ae"

  pre_install   'files/preinstall #{version}'
  post_install  'files/postinstall'

  build_depends 'createrepo', 'python-boto', 'python-createrepo_c', 'git'

  def build
  end

  def install
  end

end
