<if @shaded_p@ ne "t">

  <if @entries:rowcount@ gt 0>

<%
    set new_package_id ""
    set old_package_id ""
%>

<multiple name="entries">

<% set new_package_id $entries(package_id) %>

    <if @one_instance_p@ false and @new_package_id@ ne @old_package_id@ and @old_package_id@ ne "">
      </ul>
    </if>

    <if @one_instance_p@ false and @new_package_id@ ne @old_package_id@>
      @entries.parent_name@
      <ul>
    </if>

    <li>
      <p>
        <b><a href="@entries.view_url@" title="View this entry">@entries.title@</a></b> <br />
        @entries.content@
        <b>by @entries.poster_first_names@ @entries.poster_last_name@</b>
        <small>(@entries.posted_time_pretty@)</small>
      </p>
    </li>

<%
    set old_package_id $new_package_id
%>
</multiple>

  <if @write_p@ eq 1>
    <p>
      <b>&raquo;</b> <a href="@entries.add_url@">Add entry</a>
    </p>
  </if>

  </if>
  <else>
    <small>No Entries</small>
  </else>

</if>
<else>
&nbsp;
</else>
