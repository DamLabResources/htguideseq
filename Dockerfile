FROM jupyter/datascience-notebook

LABEL maintainer="Will Dampier <wnd22@drexel.edu>"

USER $NB_UID

RUN conda update conda -y
RUN conda install -qy -c conda-forge mamba

COPY requirements.dev.conda /opt/

RUN mamba install -qy -c conda-forge -c bioconda --file /opt/requirements.dev.conda && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"


CMD ["start-notebook.sh"]
    
WORKDIR $HOME
