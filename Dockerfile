FROM docker:dind

RUN apk add --update alpine-sdk gettext libcap git gettext-dev libcap-dev autoconf automake libtool

RUN git clone https://github.com/threatstack/judy.git && cd judy && ./configure && make && make install && cd ..

COPY layer.tar /layer.tar

RUN mkdir /miredo && tar xf /layer.tar -C /miredo/
# RUN chroot /miredo /bin/bash -c "su - -c miredo -h"
RUN chroot /miredo /bin/bash -c "miredo -h"


# RUN git clone https://github.com/grandrew/miredo.git && cd miredo && ./autogen.sh && ./configure && make && make install

# COPY libteredo.so.5 /lib/
# COPY libtun6.so.0 /lib/
# COPY miredo /bin/miredo

# RUN /bin/miredo -h

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD []
