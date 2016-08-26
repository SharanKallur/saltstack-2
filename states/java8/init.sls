oracle-ppa:
  pkgrepo.managed:
    - humanname: Java 8 PPA
    - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main
    - file: /etc/apt/sources.list.d/java8.list
    - keyid: EEA14886
    - keyserver: keyserver.ubuntu.com

oracle-license-select:
  cmd.run:
    - unless: which java
    - name: '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections'
    - require_in:
      - pkg: oracle-java8-installer
      - cmd: oracle-license-seen-lie

oracle-license-seen-lie:
  cmd.run:
    - name: '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 seen true  | /usr/bin/debconf-set-selections'
    - require_in:
      - pkg: oracle-java8-installer

oracle-java8-installer:
  pkg:
    - installed
    - require:
      - pkgrepo: oracle-ppa

