<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="entries">
        <querytext>
		    select entry_id,
                           acs_object.name(apm_package.parent_id(e.package_id)) as parent_name,
                           (select site_node.url(site_nodes.node_id)
                            from site_nodes
                            where site_nodes.object_id = e.package_id) as base_url,
		           title,
                           content,
		           p.first_names as poster_first_names,
		           p.last_name as poster_last_name,
		           to_char(posted_date , 'HH24:MI') as posted_time_pretty,
		    from   pinds_blog_entries e,
		           acs_objects o,
		           persons p
		    where  e.entry_id = o.object_id
		    and    p.person_id = o.creation_user
		    and    package_id = :package_id
		    and    $date_clause
		    and    draft_p = 'f'
		    and    deleted_p = 'f'
		    order  by entry_date desc, posted_date desc
        </querytext>
    </fullquery>

    <fullquery name="delete_item">
          <querytext>
            update na_items set deleted_p = '1' where item_id = :delete_id
          </querytext>
    </fullquery>

</queryset>
