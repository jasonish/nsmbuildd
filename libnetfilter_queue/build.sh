configure() {
    mkdir m4
    autoreconf -ivf
    ./configure --prefix=${PREFIX}
}

build() {
    make
    make install DESTDIR=${WRKINST}
}