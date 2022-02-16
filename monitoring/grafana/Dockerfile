FROM grafana/grafana:5.0.0
COPY conf/providers.yml /etc/grafana/provisioning/dashboards/
COPY conf/datasources.yml /etc/grafana/provisioning/datasources/
COPY dashboards/* /var/lib/grafana/dashboards/