#
# /weblogger-portlet/www/weblogger-portlet.tcl
#
# simon@bcuni.net
#
# The logic for the weblogger portlet
# 

ad_page_contract {
    The display logic for the weblogger portlet
    @author Simon Carstensen (simon@bcuni.net)
} {
    item_id:integer,notnull,optional,multiple
} -properties {

}

set user_id [ad_conn user_id]
set write_p [ad_permission_p $user_id admin]

array set config $cf	
set shaded_p $config(shaded_p)

set list_of_package_ids $config(package_id)
set one_instance_p [ad_decode [llength $list_of_package_ids] 1 1 0]

set read_p 0
array set package_read_p [list]
array set package_create_p [list]
foreach package_id $config(package_id) {
    set package_read_p($package_id) [permission::permission_p -object_id $package_id -privilege read]
    set package_create_p($package_id) [permission::permission_p -object_id $package_id -privilege create]
    if { $package_read_p($package_id) } {
        set read_p 1
    }
}

# Retrieve the days shown in the portlet from the parameter of the associated package
# As we do not have user parameters, choose the first package when outside a community.
set num_days_shown [parameter::get -package_id [lindex $list_of_package_ids 0] -parameter "NumDaysOnFrontPage" -default "30"]

db_multirow -extend { view_url add_url } entries entries {} {
    if { !$package_read_p($package_id) } {
        continue
    }
    set content [string_truncate -len 100 -- $content]
    set view_url "${base_url}one-entry?[export_vars { entry_id }]"
    if { $package_create_p($package_id) } {
        set add_url "${base_url}entry-edit"
    }
}
