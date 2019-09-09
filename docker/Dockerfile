# Main ROS/Cuda environment for local development.  Creates ros_env image.
# Adjust the cuda version below for your computer.
FROM nvidia/cudagl:9.0-devel-ubuntu16.04

# Develop
RUN apt-get update && apt-get install -y \
        software-properties-common \
        wget curl git cmake cmake-curses-gui \
        libboost-all-dev \
        libflann-dev \
        libgsl0-dev \
        libgoogle-perftools-dev \
        libeigen3-dev

# Intall some basic GUI and sound libs
RUN apt-get update && apt-get install -y \
        xz-utils file locales dbus-x11 pulseaudio dmz-cursor-theme \
        fonts-dejavu fonts-liberation hicolor-icon-theme \
        libcanberra-gtk3-0 libcanberra-gtk-module libcanberra-gtk3-module \
        libasound2 libgtk2.0-0 libdbus-glib-1-2 libxt6 libexif12 \
        libgl1-mesa-glx libgl1-mesa-dri language-pack-en \
        && update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX

# Intall some basic GUI tools
RUN apt-get update && apt-get install -y \
        cmake-qt-gui \
        gnome-terminal

# Install ROS
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update && apt-get install -y ros-kinetic-desktop-full ros-kinetic-nmea-msgs ros-kinetic-nmea-navsat-driver ros-kinetic-sound-play ros-kinetic-jsk-visualization ros-kinetic-grid-map ros-kinetic-gps-common ros-kinetic-automotive-autonomy-msgs ros-kinetic-can-msgs ros-kinetic-tf ros-kinetic-tf2
RUN apt-get update && apt-get install -y ros-kinetic-controller-manager ros-kinetic-ros-control ros-kinetic-ros-controllers ros-kinetic-gazebo-ros-control ros-kinetic-joystick-drivers
RUN apt-get update && apt-get install -y libnlopt-dev freeglut3-dev qtbase5-dev libqt5opengl5-dev libssh2-1-dev libarmadillo-dev libpcap-dev gksu libgl1-mesa-dev libglew-dev python-wxgtk3.0 software-properties-common libmosquitto-dev libyaml-cpp-dev python-flask python-requests

# Add basic user
ENV USERNAME govvijay
ENV PULSE_SERVER /run/pulse/native
RUN useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        # Replace 1000 with your user/group id
        usermod  --uid 1000 $USERNAME && \
        groupmod --gid 1000 $USERNAME

# Change user
USER govvijay

# Setup .bashrc for ROS and Julia
RUN echo "source /opt/ros/kinetic/setup.bash" >> /home/$USERNAME/.bashrc && \
        #Fix for qt and X server errors
        echo "export QT_X11_NO_MITSHM=1" >> /home/$USERNAME/.bashrc && \
        # cd to home on login
        echo "cd" >> /home/$USERNAME/.bashrc && \
        echo "export PATH=$PATH:/opt/julia/bin/" >> /home/$USERNAME/.bashrc && \
	echo "source /home/govvijay/catkin_ws/devel/setup.bash" >> /home/$USERNAME/.bashrc

RUN sudo rosdep init \
        && rosdep update

###################################
# Utilities
RUN sudo apt-get update && \
	sudo apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o DPkg::Options::="--force-confold" && \
	sudo apt-get install -y --no-install-recommends \
	apt-utils \
    man-db \
    libc6 \
    libc6-dev \
    build-essential \
    wget \
    curl \
    file \
    vim \
    gedit \
    tmux \
    unzip \
    pkg-config \
    cmake \
    gfortran \
    gettext \
    libreadline-dev \
    libncurses-dev \
    libpcre3-dev \
    libgnutls28-dev \
    libzmq3-dev \
    python \
    python-yaml \
    python-m2crypto \
    python-crypto \
    msgpack-python \
    python-dev \
    python-setuptools \
    supervisor \
    python-jinja2 \
    python-requests \
    python-isodate \
    python-git \
    python-pip \
    && sudo apt-get clean && \
	sudo rm -rf /var/lib/apt/lists/*	

#############
# Julia language & libraries
# Install julia 0.6.4
RUN sudo mkdir -p /opt/julia-0.6.4 && \
    sudo curl -s -L https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.4-linux-x86_64.tar.gz | sudo tar -C /opt/julia-0.6.4 -x -z --strip-components=1 -f - && \
	sudo ln -fs /opt/julia-0.6.4 /opt/julia-0.6

# Make v0.6.4 default julia
RUN sudo ln -fs /opt/julia-0.6.4 /opt/julia

# add, build, compile packages, -e = evaluate
RUN	/opt/julia/bin/julia -e 'ENV["PYTHON"]="/usr/bin/python2"; Pkg.add("PyCall")' && \
	#/opt/julia/bin/julia -e 'Pkg.add("CSV")' && \
	#/opt/julia/bin/julia -e 'Pkg.add("ControlSystems")' && \
	#/opt/julia/bin/julia -e 'Pkg.add("DataFrames")' && \
	/opt/julia/bin/julia -e 'Pkg.add("Ipopt")' && \
	/opt/julia/bin/julia -e 'Pkg.add("JuMP")' && \
	#/opt/julia/bin/julia -e 'Pkg.add("NearestNeighbors")' && \
	#/opt/julia/bin/julia -e 'Pkg.add("NPZ")' && \
	#/opt/julia/bin/julia -e 'Pkg.add("PyPlot")' && \
	#/opt/julia/bin/julia -e 'Pkg.add("RobotOS")' && \
	#/opt/julia/bin/julia -e 'Pkg.add("YAML")' && \
	#/opt/julia/bin/julia -e 'using CSV' && \
	#/opt/julia/bin/julia -e 'using ControlSystems' && \
	#/opt/julia/bin/julia -e 'using DataFrames' && \
	/opt/julia/bin/julia -e 'using Ipopt' && \
	/opt/julia/bin/julia -e 'using JuMP' && \
	#/opt/julia/bin/julia -e 'using NearestNeighbors' && \
	#/opt/julia/bin/julia -e 'using NPZ' && \
	#/opt/julia/bin/julia -e 'using PyPlot' && \
	#/opt/julia/bin/julia -e 'using RobotOS' && \
	#/opt/julia/bin/julia -e 'using YAML' && \
	/opt/julia/bin/julia -e 'using PyCall'

# Install Pyjulia
RUN pip2 install --user julia &&\
    pip2 install --upgrade pip==9.0.3 && \
    sudo apt-get -y install python-matplotlib python-scipy && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*	

# Video utilities
RUN sudo apt-get update && \
	sudo apt-get -y install --no-install-recommends hdf5-tools && \
	sudo apt-get install -y --no-install-recommends build-essential gfortran pkg-config liblapack-dev libblas-dev && \
	sudo apt-get -y install --no-install-recommends libfreetype6-dev && \
	sudo apt-get -y install --no-install-recommends libpng12-dev && \
	sudo apt-get clean && \
	sudo rm -rf /var/lib/apt/lists/*
###############################################

# Setting
ENV LANG="en_US.UTF-8"
RUN echo "export LANG=\"en_US.UTF-8\"" >> /home/$USERNAME/.bashrc

# Install dev tools
RUN sudo apt-get -y install vim tmux gedit

# Change Terminal Color
RUN gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false
RUN gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false
RUN gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "#000000"

# Default CMD
CMD ["/bin/bash"]
