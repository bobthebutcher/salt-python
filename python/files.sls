{% from 'python/map.jinja' import python_versions with context %}
{% set master_files_dir =  salt['pillar.get']('master_files_dir', '/srv/salt/files') %}

pip:
  file.managed:
    - name: {{ master_files_dir }}/get-pip.py
    - source: https://bootstrap.pypa.io/get-pip.py
    - skip_verify: True

{% for python in python_versions %}
Python-{{ python.release }}:
  file.managed:
    - name: {{ master_files_dir }}/Python-{{ python.release }}.tgz
    - source: https://www.python.org/ftp/python/{{ python.release }}/Python-{{ python.release }}.tgz
    - source_hash: {{ python.hash }}
{% endfor %}
