ad_library {

    Procedures to support the weblogger admin portlet

    @creation-date May 2003
    @author simon@bcuni.net

}

namespace eval weblogger_admin_portlet {}

ad_proc -private weblogger_admin_portlet::get_my_name {} {
    return "weblogger_admin_portlet"
}


ad_proc -public weblogger_admin_portlet::get_pretty_name {} {
    return "Weblogger Administration"
}



ad_proc -private weblogger_admin_portlet::my_package_key {} {
    return "weblogger-portlet"
}



ad_proc -public weblogger_admin_portlet::link {} {
    return ""
}



ad_proc -public weblogger_admin_portlet::add_self_to_page {
    {-portal_id:required}
    {-page_name ""}
    {-package_id:required}
} {
    Adds a weblogger admin PE to the given portal

    @param portal_id The page to add self to
    @param package_id The package_id of the weblogger package

    @return element_id The new element's id
} {
    return [portal::add_element_parameters \
                -portal_id $portal_id \
                -portlet_name [get_my_name] \
                -key package_id \
                -value $package_id
           ]
}



ad_proc -public weblogger_admin_portlet::remove_self_from_page {
    {-portal_id:required}
} {
    Removes a weblogger admin PE from the given page
} {
    portal::remove_element \
        -portal_id $portal_id \
        -portlet_name [get_my_name]
}



ad_proc -public weblogger_admin_portlet::show {
    cf
} {
} {
    portal::show_proc_helper \
        -package_key [my_package_key] \
        -config_list $cf \
        -template_src "weblogger-admin-portlet"

}


