#! /bin/bash
set -e

# version to build
#VERSION=v0.14.25
VERSION=stable

# host dir to copy result to
DIST_DIR=knxd-dist-$VERSION
IMAGE_NAME=heziegl/rpi-knxd-build:$VERSION


# build linknx
echo "building docker image for version $VERSION ..."
sudo docker build --build-arg VERSION=$VERSION -t $IMAGE_NAME .

# copy dist from container to docker host
echo copying results to $DIST_DIR ...
mkdir -p $DIST_DIR
sudo docker run --rm=true -v $(pwd)/$DIST_DIR:/dist $IMAGE_NAME


# create README.MD in dist
cat > $DIST_DIR/README.MD << EOF
#ToDo
\`\`\`bash
sudo dpkg -i knxd_*.deb knxd-tools_*.deb
# check if linknx runs
./knxd --version
\`\`\`
EOF
