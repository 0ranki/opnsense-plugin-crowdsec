PLUGIN_NAME=		crowdsec
PLUGIN_VERSION=		1.0.0
#PLUGIN_REVISION=	1
PLUGIN_DEPENDS=		crowdsec crowdsec-firewall-bouncer
PLUGIN_COMMENT=		Lightweight and collaborative security engine
PLUGIN_MAINTAINER=	marco@crowdsec.net
PLUGIN_WWW=		https://crowdsec.net/

.include "../../Mk/plugins.mk"
