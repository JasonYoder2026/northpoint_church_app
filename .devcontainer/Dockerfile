FROM ubuntu:latest

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Clone the Flutter SDK
RUN git clone https://github.com -b stable /opt/flutter

# Add Flutter to the path
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run basic setup and enable web support
RUN flutter doctor
RUN flutter config --enable-web
