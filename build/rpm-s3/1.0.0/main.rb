class RPM_S3_1_0_0 < FPM::Cookery::Recipe
  name          'rpm-s3'
  version       '1.0.0'
  revision      0
  description   'Reads SQS queues to grab rpms from S3 and build/append a new repodata to the bucket, turning into a yum repo.'
  homepage      'https://github.com/moip/rpm-s3'
  section       'admin'

  source        "https://s3.amazonaws.com/rpm-s3/rpm-s3-#{version}.tar.gz"
  sha256        "710c5153100a59593afdaf2ffe5b4a63604e23f3d764150999693db9ff3c1f36"

 # pre_install   "files/preinstall #{version}"
  post_install  'files/postinstall'

  build_depends 'createrepo', 'python-boto', 'python-createrepo_c', 'git'

  def build
  end

  def install
    path = get_activemq_path
    
    install_whole_path(path)
  end
  
  def get_activemq_path
    path = File.join(File.basename(source, '.tar.gz'))
    
    builddir(path)
  end
  
  def install_whole_path
    rpm-s3.mkdir
    whole_path = File.join(path)
    rpm-s3.install(whole_path)
  end
end
