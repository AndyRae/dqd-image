FROM rocker/r-ver:4.4.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        openjdk-11-jdk \
        libxml2-dev \
        libpcre2-dev \
        libdeflate-dev \
        liblzma-dev \
        libbz2-dev \
        zlib1g-dev \
        pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && R CMD javareconf

RUN install2.r --error --ncpus 2 \
    rJava \
    remotes \
    ParallelLogger \
    SqlRender \
    DatabaseConnector

RUN R -e "remotes::install_github('OHDSI/DataQualityDashboard')"

RUN mkdir -p /output /jdbc \
    && R -e 'DatabaseConnector::downloadJdbcDrivers("postgresql", pathToDriver = "/jdbc")'

COPY run_dqd.R /run_dqd.R

RUN adduser --disabled-password --gecos "" --uid 1000 r-dqd \
    && chown -R r-dqd:r-dqd /output

USER r-dqd

VOLUME ["/output"]

ENTRYPOINT ["Rscript", "/run_dqd.R"]
