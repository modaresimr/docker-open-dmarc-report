FROM boxedcode/alpine-nginx-php-fpm:v1.7.2

MAINTAINER Robert Schumann <gutmensch@n-os.org>

ENV REPORT_PARSER_SOURCE="https://github.com/techsneeze/dmarcts-report-parser/archive/master.zip" \
    REPORT_VIEWER_SOURCE="https://github.com/techsneeze/dmarcts-report-viewer/archive/master.zip"\
	REPORT_DASHBOARD_SOURCE="https://github.com/userjack6880/Open-DMARC-Analyzer/archive/master.zip"

COPY ./manifest/ /

RUN set -x \
      && apk update \
      && apk add expat-dev mariadb-dev \
      && wget -q --no-check-certificate -O parser.zip $REPORT_PARSER_SOURCE \
      && wget -q --no-check-certificate -O viewer.zip $REPORT_VIEWER_SOURCE \
	  && wget -q --no-check-certificate -O dashboard.zip $REPORT_DASHBOARD_SOURCE \
      && unzip parser.zip && cp -v dmarcts-report-parser-master/* /usr/bin/ && rm -f parser.zip \
      && unzip viewer.zip && cp -v dmarcts-report-viewer-master/* /var/www/viewer/ && rm -f viewer.zip \
	  && unzip dashboard.zip && cp -v Open-DMARC-Analyzer/* /var/www/Open-DMARC-Analyzer/ && rm -f dashboard.zip \
	  && ln -s /var/www/viewer/ /var/www/Open-DMARC-Analyzer/viewer \
      && sed -i "1s/^/body { font-family: Sans-Serif; }\n/" /var/www/viewer/default.css \
      && (echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan \
      && perl -MCPAN -e 'foreach (@ARGV) { CPAN::Shell->rematein("notest", "install", $_) }' \
        IO::Compress::Gzip \
        Getopt::Long \
	Mail::IMAPClient \
	Mail::Mbox::MessageParser \
        MIME::Base64 \
        MIME::Words \
        MIME::Parser \
        MIME::Parser::Filer \
		File::MimeInfo \
        XML::Parser \
        XML::Simple \
        DBI \
        DBD::mysql \
	Socket \
	Socket6 \
        PerlIO::gzip \
        IO::Socket::SSL \
      && apk del mariadb-dev expat-dev \
      && apk add mariadb-client-libs \
      && sed -i 's%.*root /var/www/html;%        root /var/www/Open-DMARC-Analyzer;%g' /etc/nginx/conf.d/default.conf \
      && sed -i 's/.*index index.php index.html index.htm;/        index index.php dmarcts-report-viewer.php;/g' /etc/nginx/conf.d/default.conf \
      && chmod 755 /entrypoint.sh

EXPOSE 443 80

CMD ["/bin/bash", "/entrypoint.sh"]
