##Bienvenidos al proyecto [Blacklistweb] (http://www.blacklistweb.com)

En ocasiones hemos necesitado bloquear un sitio web, ya sea de porno, descargas, drogas, malware, spyware, trackers, bots, redes sociales, warez, venta de armas, etc; y como son muchos, para ahorrar tiempo utilizamos las llamadas "listas negras" (blacklist). En Internet existen muchas "blacklist", tales como como Shallalist, Urlblacklist, Capitole (Univ Toulouse), etc, sin embargo están plagadas de subdominios y falsos positivos.

Sumado a esto, no son compatibles con Squid y al internar correrlas, Squid se detiene, generando el error: "ERROR: '.sub.example.com' is a subdomain of '.example.com'". Este problema, conocido como "overlapping domains",  ha generado diversos debates, sin que a la fecha haya una solución. Lo anterior se debe a que estas listas negras fueron concebidas para Squid2x y Squidguard, y cuando ocurrió la migración de Squid2x a 3x, dejó de aceptar listas con subdominios, generando el error.

En un intento por evitarlo, muchos han optado por editar sus listas negras manualmente. Incluso algunos han propuesto parchear squid3 para que tolere los subdominios, pero no ha funcionado bien con las versiones actuales y tampoco elimina completamente el error. 

[Blacklistweb] (http://www.blacklistweb.com)

Este proyecto (el cual es un componente de [Gateproxy] (http://www.gateproxy.com)), pretende recopilar la mayor cantidad de listas negras públicas de dominios, con el objeto de unificarlas y hacerlas compatibles con el proxy Squid. Para lograrlo, realizamos una rigurosa depuración, evitando duplicados, y las comparamos con lista de extensiones de dominios (ccTLD, ccSLD, sTLD, uTLD, gSLD, gTLD, etc), para detectar dominios inválidos, y finalmente las cotejamos con "listas blancas", externas y propias, para filtrar la mayor cantidad de falsos positivos, que se supone no deberían aparecer en estas blacklist (BLs), como correos electrónicos y dominios relacionados, como google, gmail, hotmail, yahoo, etc, páginas gubernamentales, bancos, universidades, etc, para obtener una sola mega lista de control (ACL), apta para correr en el proxy Squid y libre de "overlapping domains".

**Descripción**

- file:          blacklistweb.txt
- Update:        Jun 11/2016 20:14 UTC-05:00
- MD5:           c068d2ff2f6a750823508c21d3304291
- Domains:       2884682

**Modo de uso:**

Descargue el repositorio de blacklistweb, cree la carpeta de almacenamiento de la ACL y guarde y ejecute su script de actualización
```
clone https://github.com/maravento/blacklistweb
sudo mkdir -p /etc/acl
sudo cp blacklistweb /etc/init.d/blacklistweb.sh
sudo chown root:root /etc/init.d/blacklistweb.sh
sudo chmod +x /etc/init.d/blacklistweb.sh
sudo /etc/init.d/blacklistweb.sh
```
Y programe su ejecución semanal en el cron
```
sudo crontab -e
@weekly /etc/init.d/blacklistweb.sh
```
Edite el archivo de configuración de Squid (/etc/squid3/squid.conf o /etc/squid/squid.conf) y agregue:
```
# INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
acl blacklistweb dstdomain -i "/etc/acl/blacklistweb.txt"
http_access deny blacklistweb
```
Por defecto la ruta de blacklistweb.txt es /etc/acl y del script /etc/init.d. Para cambiarlo edite el script de actualización blacklistweb.sh

**Edición**

La ACL blacklistweb, al ser una "lista negra" con más de 2 millones de dominios bloqueados, editarla manualmente puede ser algo muy frustrante y lento. Por esta razón, si detecta un falso positivo, recomendamos crear una "lista blanca" y poner ahí los dominios que quiera excluir de blacklistweb y reportarnos el incidente para corregirlo en la próxima actualización.
```
acl whitelistweb dstdomain -i "/etc/acl/whitelistweb.txt
acl blacklistweb dstdomain -i "/etc/acl/blackdomains.txt
http_access allow whitelistweb
http_access deny blackdomains 
```
A modo de ejemplo, en la regla anterior hemos creado la acl blackdomains, que servirá para bloquear los dominios .youtube.com .googlevideo.com y .ytimg.com (no incluidos en blacklistweb) y whitelistweb para incluir los falsos positivos de blacklistweb y también para autorizar el subdominio accounts.youtube.com (desde Feb 2014, Google utiliza el subdominio accounts.youtube.com para autenticar sus servicios)

**Importante**

La acl Blacklistweb está diseñada exclusivamente para bloquear dominios. Para los interesados en bloquear banners y otras modalidades publicitarias, visite el foro Alterserv.

**Contribuciones**

Los interesados pueden contribuir, enviándonos enlaces de nuevas BLs, para ser incluidas en este proyecto. Estas deberán alojarse de forma permanente en un sitio público, de fácil descarga, vía http/s y/o wget preferentemente, con control de versiones.

**FICHA TÉCNICA DEL PROYECTO**
**(BLs incluidas en Blacklistweb)**

###General Public and Malware BLs
[Shallalist] (http://www.shallalist.de/Downloads/shallalist.tar.gz)
[UrlBlacklist] (http://urlblacklist.com/?sec=download)
[Capitole - Direction du Système d'Information (DSI)] (http://dsi.ut-capitole.fr/blacklists/download/)
[MESD blacklists] (http://squidguard.mesd.k12.or.us/blacklists.tgz)
[Yoyo Serverlist] (http://pgl.yoyo.org/adservers/serverlist.php?hostformat=nohtml)
[Passwall] (http://www.passwall.com/blacklist.txt)
[Oleksiig Blacklist] (https://raw.githubusercontent.com/oleksiig/Squid-BlackList/master/denied_ext.conf)
[Someonewhocares] (http://someonewhocares.org/hosts/hosts)
[HP Hosts-file] (http://hosts-file.net/download/hosts.txt)
[Winhelp2002] (http://winhelp2002.mvps.org/hosts.txt)
[Cibercrime-Tracker] (http://cybercrime-tracker.net/all.php)
[Joewein Blacklist] (http://www.joewein.de/sw/bl-text.htm)
[Tracking-Addresses] (https://github.com/10se1ucgo/DisableWinTracking/wiki/Tracking-Addresses)
[Adaway] (http://adaway.org/hosts.txt)
[Lehigh Malwaredomains] (http://malwaredomains.lehigh.edu/files/)
[Easylist for adblockplus] (https://easylist-downloads.adblockplus.org/malwaredomains_full.txt)
[Zeus tracker] (https://zeustracker.abuse.ch/blocklist.php?download=squiddomain)
[Malwaredomain Hosts List] (http://www.malwaredomainlist.com/hostslist/hosts.txt)
[Malware-domains] (http://www.malware-domains.com/)
[malc0de] (http://malc0de.com/bl/)
###Ransomware BL
[Ransomware Abuse] (https://ransomwaretracker.abuse.ch/blocklist/)
###TLDs
[IANA] (https://www.iana.org/domains/root/db)
[Mozilla Public Suffix] (https://publicsuffix.org/list/public_suffix_list.dat)
###Own lists included
[Blackdomains] (https://drive.google.com/file/d/0B0IOC2-GhY8PY1hDT0lmVGVYWkE/view)
[Whitetlds] (https://drive.google.com/file/d/0B0IOC2-GhY8PaEQxeHJUek12RlE/view)
[Whitedomains] (https://drive.google.com/file/d/0B0IOC2-GhY8PczREUGI2TEFqa2c/view)

**Agradecimientos**

Agradecemos a todos aquellos que han contribuido a este proyecto, en especial [novatoz.com] (http://www.novatoz.com)

© 2016 [Blacklistweb] (http://www.blacklistweb.com) por [maravento] (http://www.maravento.com) se distribuye bajo una [Licencia Creative Commons Atribución-NoComercial-CompartirIgual 4.0 Internacional] (http://creativecommons.org/licenses/by-nc-sa/4.0/). Basada en una obra en maravento. Permisos que vayan más allá de lo cubierto por esta licencia pueden encontrarse en maravento
