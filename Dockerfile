FROM rocker/r-ver:4.4.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
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
    && curl -sL -o /jdbc/postgresql.jar \
        "https://jdbc.postgresql.org/download/postgresql-42.7.3.jar"

COPY run_dqd.R /run_dqd.R

VOLUME ["/output"]

ENTRYPOINT ["Rscript", "/run_dqd.R"]
