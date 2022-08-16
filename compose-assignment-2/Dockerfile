# create your custom drupal image here, based of official drupal

FROM drupal:8.2

# apt-get update ====> delete the cache ?
# \ backslash = include the next line in this command
RUN apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*          
        # common one... remove the specific files... see this command in many images... just to keep clean

WORKDIR /var/www/html/themes

RUN git clone --branch 8.x-4.x --single-branch --depth 1 https://git.drupalcode.org/project/bootstrap.git \
# --branch 8.x-4.x ====================> using a specific branch 8.x-4.x
# --single-branch && --depth 1 ========> only download the latest copy... only the absolute latest commit ??
# technically, this is all we need... a single branch... because, if we change the drupal branch.. we need to build another image anyway
    # it saves space & download time... because, we dont need the whole history of repository... we just need latest commit
    && chown -R www-data:www-data bootstrap
    # docker technically runs everything as root... but apache webserver, needs them to be run as some user
    # -R = recursively...
    # www-data:www-data ========> first one is user... 2nd one after colon is group
    # bootstrap = the folder/directory whose permissions we changed

WORKDIR /var/www/html
