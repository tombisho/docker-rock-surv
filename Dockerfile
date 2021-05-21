#
# Rock R Server Dockerfile with DataSHIELD
#
# https://github.com/obiba/docker-rock-demo
#

FROM datashild/rock-base:latest

ENV DSGEO_VERSION master
ENV DSEXPOSOME_VERSION master
ENV MEAL_VERSION master
ENV DSOMICS_VERSION master

ENV ROCK_LIB /var/lib/rock/R/library

# Additional system dependencies
#RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y ???

# Update R packages
#RUN Rscript -e "update.packages(ask = FALSE, repos = c('https://cloud.r-project.org'), instlib = '/usr/local/lib/R/site-library')"

# Install new R packages

# dsGeo
RUN Rscript -e "remotes::install_version('rgdal', version = '1.5-12', repos = 'https://cloud.r-project.org', upgrade = 'never')"
RUN Rscript -e "remotes::install_github('tombisho/dsGeo', ref = '$DSGEO_VERSION', dependencies = TRUE, upgrade = FALSE, lib = '$ROCK_LIB')"

# dsExposome
RUN Rscript -e "BiocManager::install(c()'bumphunter', 'missMethyl', 'rexposome'), update = FALSE, ask = FALSE, dependencies = TRUE, update = FALSE, lib = '$ROCK_LIB')"
RUN Rscript -e "remotes::install_github('isglobal-brge/dsExposome', ref = '$DSEXPOSOME_VERSION', repos = c('https://cloud.r-project.org', 'https://cran.datashield.org'), dependencies = TRUE, upgrade = FALSE, lib = '$ROCK_LIB')"

# dsOmics
RUN Rscript -e "BiocManager::install(c()'Biobase', 'SNPRelate', 'GENESIS', 'GWASTools', 'GenomicRanges', 'SummarizedExperiment', 'DESeq2', 'edgeR'), update = FALSE, ask = FALSE, dependencies = TRUE, update = FALSE, lib = '$ROCK_LIB')"
RUN Rscript -e "remotes::install_github('isglobal-brge/MEAL', ref = '$MEAL_VERSION', dependencies = TRUE, upgrade = FALSE, lib = '$ROCK_LIB')"
RUN Rscript -e "remotes::install_github('isglobal-brge/dsOmics', ref = '$DSOMICS_VERSION', dependencies = TRUE, upgrade = FALSE, lib = '$ROCK_LIB')"

RUN chown -R rock $ROCK_LIB
