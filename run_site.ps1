param (
    [switch]$bundle_update = $false
 )

# Get the Docker environment "stuff" from the helper script that runs as elevated perms
#$CMDPath = Split-Path -Parent $PSCommandPath
#$DockerEnvFile = ($CMDPath + '\docker_machine_env.txt')
#
#if( -Not (Test-Path $DockerEnvFile )) {
#  Write-Host "Please run docker_machine_helper.ps1 before running this script"
#  exit
#}
#Get-Content $DockerEnvFile | Invoke-Expression

# Set to the name of the Docker image you want to use
$DOCKER_IMAGE_NAME='lr-cvt-gh-pages'

# Stop on first error
$ErrorActionPreference = "Stop"

if( Test-Path Dockerfile ) {
  # Build a custom Docker image that has custom Jekyll plug-ins installed
  docker build --tag $DOCKER_IMAGE_NAME --file .\Dockerfile .

  # Remove dangling images from previous runs
  @(docker images --filter "dangling=true" -q) | % {docker rmi -f $_}
}
else {
  # Use an existing Jekyll Docker image
  $DOCKER_IMAGE_NAME='jekyll/jekyll'
}

#echo "***********************************************************"
#echo "  Your site will be available at http://$(docker-machine ip $DOCKER_MACHINE_NAME):4000"
#echo "***********************************************************"

# Translate your current directory into the file share mounted in the Docker host
$host_vol = $pwd.Path.Replace("C:\", "/c/").Replace("\", "/")
echo "Mounting $host_vol to /src on the Docker container"

# Start Jekyll and watch for changes OROROROR update jekyll dependencies and set them as system gems
# NOTE: YOU MUST SETUP SHARED DRIVES BEFORE RUNNING THIS
# See https://blogs.msdn.microsoft.com/stevelasker/2016/06/14/configuring-docker-for-windows-volumes/ for details
if ($bundle_update) {
  docker run --rm `
    --volume=${host_vol}:/src `
    -w /src `
    --publish 4000:4000 `
    $DOCKER_IMAGE_NAME `
    /src/jekyll_update.sh
}
else {
  docker run --rm `
    --volume=${host_vol}:/src `
    -w /src `
    --publish 4000:4000 `
    $DOCKER_IMAGE_NAME `
    /src/jekyll.sh
}
