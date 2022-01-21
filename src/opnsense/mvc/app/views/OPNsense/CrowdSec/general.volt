{# SPDX-License-Identifier: MIT #}
{# SPDX-FileCopyrightText: © 2021 CrowdSec <info@crowdsec.net> #}


<script>
    $( document ).ready(function() {
        var data_get_map = {'frm_GeneralSettings':"/api/crowdsec/general/get"};
        mapDataToFormUI(data_get_map).done(function(data){
            // place actions to run after load, for example update form styles.
        });

        // link save button to API set action
        $("#saveAct").click(function(){
            saveFormToEndpoint(url="/api/crowdsec/general/set",formid='frm_GeneralSettings',callback_ok=function(){
                $("#settingsSavedMsg").text("Saving settings....").removeClass("hidden");
                // action to run after successful save, for example reconfigure service.
                ajaxCall(url="/api/crowdsec/service/reload", sendData={},callback=function(data,status) {
                    $("#settingsSavedMsg").html(
                        '<i class="fa fa-check text-success"></i> Settings have been saved, services restarted.'
                    ).removeClass("hidden");
                });
            });
        });

        if(window.location.hash != "") {
            $('a[href="' + window.location.hash + '"]').click()
        }
        $('.nav-tabs a').on('shown.bs.tab', function (e) {
            history.pushState(null, null, e.target.hash);
        });
    });
</script>

<style type="text/css">
#introduction a.btn-info {
  color: black;
  margin: 3px;
}

.tab-pane {
  margin: 10px;
}
</style>

<ul class="nav nav-tabs" role="tablist" id="maintabs">
    <li class="active"><a data-toggle="tab" id="introduction-tab" href="#introduction"><b>Introduction</b></a></li>
    <li><a data-toggle="tab" id="settings-tab" href="#settings"><b>Settings</b></a></li>
</ul>

<div class="content-box tab-content">
    <div id="introduction" class="tab-pane fade in active">
        <p>This plugin installs a CrowdSec agent/<a href="https://doc.crowdsec.net/docs/next/local_api/intro">LAPI</a>
        node, and a <a href="https://docs.crowdsec.net/docs/bouncers/firewall/">Firewall Bouncer</a>.</p>

        <p>Out of the box, by enabling them in the "Settings" tab, they can protect the OPNsense server
        by receiving thousands of IP addresses of active attackers, which are immediately banned at the
        firewall level. In addition, the logs of the ssh service and OPNsense administration interface are
        analyzed for possible brute-force attacks; any such scenario triggers a ban and is reported to the
        CrowdSec Central API
        (meaning <a href="https://docs.crowdsec.net/docs/concepts/">timestamp, scenario, attacking IP</a>).</p>

        <p>Other attack behaviors can be recognized on the OPNsense server and its plugins, or 
        <a href="https://doc.crowdsec.net/docs/next/user_guides/multiserver_setup">any other agent</a>
        connected to the same LAPI node. Other types of remediation are possible (ex. captcha test for scraping attempts).</p>

        <p>Please refer to the <a href="https://crowdsec.net/blog/category/tutorial/">tutorials</a> to explore
        the possibilities.</p>

        <p>A few remarks:</p>

        <ul>
            <li>
                If your OPNsense is &lt;22.1, you must check "Disable circular logs" in the Settings menu for the
                ssh and web-auth parsers to work. If you upgrade to 22.1, it will be done automatically.
                See <a href="https://github.com/crowdsecurity/opnsense-plugin-crowdsec/blob/main/src/etc/crowdsec/acquis.d/opnsense.yaml">acquis.d/opnsense.yaml</a>
            </li>
            <li>
                At the moment, the CrowdSec package for OPNsense is fully functional on the
                command line but its web interface is limited; you can only list the installed objects and revoke
                <a href="https://docs.crowdsec.net/docs/user_guides/decisions_mgmt/">decisions</a>. For anything else
                you need the shell.
            </li>
            <li>
                Do not enable/start the agent and bouncer services with <code>sysrc</code> or <code>/etc/rc.conf</code>
                like you would on vanilla freebsd, the plugin takes care of that.
            </li>
            <li>
                The parsers, scenarios and all objects from the <a href="https://hub.crowdsec.net/">CrowdSec Hub</a>
                are periodically upgraded. The
                <a href="https://hub.crowdsec.net/author/crowdsecurity/collections/freebsd">crowdsecurity/freebsd</a> and 
                <a href="https://hub.crowdsec.net/author/crowdsecurity/collections/opnsense">crowdsecurity/opnsense</a>
                collections are installed by default.
            </li>
        </ul>

        <div>
            <a class="btn btn-default btn-info" href="https://doc.crowdsec.net/">
                crowdsec.net
            </a>
            <a class="btn btn-default btn-info" href="https://doc.crowdsec.net/">
                Documentation
            </a>
            <a class="btn btn-default btn-info" href="https://crowdsec.net/blog/">
                Blog
            </a>
            <a class="btn btn-default btn-info" href="https://app.crowdsec.net/">
                Console
            </a>
            <a class="btn btn-default btn-info" href="https://hub.crowdsec.net/">
                CrowdSec Hub
            </a>
        </div>

        <div>
            <a class="btn btn-default btn-info" href="https://github.com/crowdsecurity/crowdsec">
                GitHub
            </a>
            <a class="btn btn-default btn-info" href="https://discourse.crowdsec.net/">
                Discourse
            </a>
            <a class="btn btn-default btn-info" href="https://discord.com/invite/wGN7ShmEE8">
                Discord
            </a>
            <a class="btn btn-default btn-info" href="https://twitter.com/Crowd_Security">
                Twitter
            </a>
        </div>
    </div>

    <div id="settings" class="tab-pane fade active">
        <div class="alert alert-info hidden" role="alert" id="settingsSavedMsg">
        </div>
        <div  class="col-md-12">
            {{ partial("layout_partials/base_form",['fields':generalForm,'id':'frm_GeneralSettings'])}}
        </div>

        <div class="col-md-12">
            <button class="btn btn-primary"  id="saveAct" type="button"><b>{{ lang._('Save') }}</b></button>
        </div>
    </div>
</div>

