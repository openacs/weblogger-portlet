<if @read_p@ true>
  <if @shaded_p@ ne "t">

    <if @entries:rowcount@ gt 0>
      <multiple name="entries">
        @entries.parent_name@
        <ul>
          <group column="package_id">
            <if @entries.entry_id@ not nil>
              <li>
                <p>
                  <b><a href="@entries.view_url@" title="View this entry">@entries.title@</a></b> <br />
                  @entries.content;noquote@
                  <br><b>#weblogger-portlet.lt_by_entriesposter_firs#</b>
                  <small>(@entries.posted_time_pretty@)</small>
                </p>
              </li>
            </if>
          </group>
        </ul>
        <if @entries.add_url@ not nil>
          <p>
            <b>#weblogger-portlet.raquo#</b> <a href="@entries.add_url@">#weblogger-portlet.Add_entry#</a>
          </p>
        </if>
      </multiple>
    </if>
    <else>
      <small>#weblogger-portlet.No_Entries#</small>
    </else>
  </if>
  <else>
  &nbsp;
  </else>
</if>

