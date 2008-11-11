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
    length:integer,optional
} -properties {

}

# Default value; TODO get from package paramete
if  { ![info exists length]} {
    set length 100
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

template::list::create -name blogs -multirow entries -key entry_id -pass_properties {
} -elements {
    item {
        label ""
        display_template {
          <p class="blog-name"><b>@entries.parent_name@</b>
            <small><if @entries.add_url@ not nil><a class="button" href="@entries.add_url@">#weblogger-portlet.Add_entry#</a>
             </if>
            <a class="button" href="@entries.base_url@">\#weblogger-portlet.FullView\#</a></small>
          </p>
        <ul>
          <group column="package_id">
            <if @entries.entry_id@ not nil>
            <li class="blog-entry"> <i><a href="@entries.view_url@" title="View this entry">@entries.title@</a></i> <small>(@entries.posted_time_pretty@)</small>
              <br><span class="blog-content">@entries.content;noquote@</span> 
            </li>
            </if>
          </group></ul>
        }
    }
}

db_multirow -extend { view_url add_url } entries entries {} {
    if { !$package_read_p($package_id) } {
        continue
    }
    set content [string_truncate -len $length -- $content]
    set view_url "${base_url}one-entry?[export_vars { entry_id }]"
    if { $package_create_p($package_id) } {
        set add_url "${base_url}entry-edit"
    }
}
