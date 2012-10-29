
set @page_seq = 'page';
set @page_layout_seq = 'page_layout';
set @region_seq = 'region';
set @region_widget_seq = 'region_widget';
set @user_seq = 'person';
set @person_association_seq = 'person_association';
set @groups_seq = 'groups';
set @group_members_seq = 'group_members';
set @widget_seq = 'widget';
set @granted_authority_seq = 'granted_authority';
set @widget_comment_seq = 'widget_comment';
set @widget_rating_seq = 'widget_rating';
set @portal_preference_seq = 'portal_preference';
set @tag_seq = 'tag';
set @widget_tag_seq = 'widget_tag';
set @category_seq = 'category';
set @page_template_seq = 'page_template';
set @page_template_region_seq = 'page_template_region';
set @page_template_widget_seq = 'page_template_widget';
set @page_user_seq = 'page_user';
set @token_info_seq = 'token_info';
set @oauth_consumer_store_seq = 'oauth_consumer_store';
set @application_data_seq = 'application_data';

CREATE TABLE IF NOT EXISTS RAVE_PORTAL_SEQUENCES (seq_name VARCHAR(255) PRIMARY KEY NOT NULL, seq_count BIGINT(19));
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@page_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@page_layout_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@region_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@region_widget_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values ('region_widget_preference', 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@user_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@person_association_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@groups_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@group_members_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@widget_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@widget_comment_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@widget_rating_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@granted_authority_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@portal_preference_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@tag_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@widget_tag_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@category_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@page_template_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@page_template_region_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@page_template_widget_seq, 1);
INSERT INTO RAVE_PORTAL_SEQUENCES(seq_name, seq_count) values (@page_user_seq, 1);

CREATE TABLE IF NOT EXISTS RAVE_SHINDIG_SEQUENCES (seq_name VARCHAR(255) PRIMARY KEY NOT NULL, seq_count BIGINT(19));
INSERT INTO RAVE_SHINDIG_SEQUENCES(seq_name, seq_count) values (@token_info_seq, 1);
INSERT INTO RAVE_SHINDIG_SEQUENCES(seq_name, seq_count) values (@oauth_consumer_store_seq, 1);
INSERT INTO RAVE_SHINDIG_SEQUENCES(seq_name, seq_count) values (@application_data_seq, 1);

set @code_runner = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @widget_seq);
insert into widget (entity_id, title, url, type, description, author, widget_status, title_url, author_email, owner_id)
values(@code_runner, 'Jive Code Runner II','http://apphosting.jivesoftware.com/apps/dev/jivecr2/app.xml', 'OpenSocial', 'Quick app to execute OpenSocial and Jive Core API ''gists''. The Jive Code Runner II is integrated with github''s gist.', 'Mark Weitzel', 'PUBLISHED', '', 'mark.weitzel@jivesoftware.com', @user_id_1);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @widget_seq;

set @activity_stream_gadget_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @widget_seq);
insert into widget (entity_id, title, url, type, widget_status, description, author, owner_id)
values(@activity_stream_gadget_id, 'Activity Stream', 'http://localhost:8082/ActivityStreamGadget.xml', 'OpenSocial', 'PUBLISHED', 'Sample Activity Stream', 'Rober O Neill', @user_id_1);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @widget_seq;

set @three_col_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_layout_seq);
insert into page_layout (entity_id, code,  number_of_regions, render_sequence, user_selectable)
values (@three_col_id, 'columns_3', 3, 1, true);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_layout_seq;

set @newuser_col_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_layout_seq);
insert into page_layout (entity_id, code,  number_of_regions, render_sequence, user_selectable)
values (@newuser_col_id, 'columns_3_newuser', 3, 2, true);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_layout_seq;

set @person_profile_layout_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_layout_seq);
insert into page_layout (entity_id, code,  number_of_regions, render_sequence, user_selectable)
values (@person_profile_layout_id, 'person_profile', 1, 3, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_layout_seq;

set @activity_stream_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_layout_seq);
insert into page_layout (entity_id, code,  number_of_regions, render_sequence, user_selectable)
values (@activity_stream_id, 'activity_stream', 1, 4, true);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_layout_seq;

set @user_id_1 = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @user_seq);
insert into person (entity_id, username, password, expired, locked, enabled, email, default_page_layout_id, dtype, display_name, family_name, given_name)
values (@user_id_1, 'canonical', '$2a$10$TkEgze5kLy9nRlfd8PT1zunh6P1ND8WPjLojFjAMNgZMu1D9D1n4.', FALSE, FALSE, TRUE,'canonical@example.com', @three_col_id, 'User', 'Canonical User', 'User', 'Canonical');
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @user_seq;

-- Page 1 --
set @page_1_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_seq);
INSERT INTO page (entity_id, name, owner_id, parent_page_id, page_layout_id, page_type)
values (@page_1_id, 'Main', @user_id_1, null, @newuser_col_id, 'USER');
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_seq;

set @page_user_id =(SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_user_seq);
insert into page_user (entity_id, page_id, user_id, editor, render_sequence, page_status)
values (@page_user_id, @page_1_id, @user_id_1, true, 1, 'OWNER');
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_user_seq;

set @page_1_region_1 = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @region_seq);
INSERT INTO region(entity_id, page_id, render_order, locked)
values (@page_1_region_1, @page_1_id, 1, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @region_seq;

set @page_1_region_2 = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @region_seq);
INSERT INTO region(entity_id, page_id, render_order, locked)
values (@page_1_region_2, @page_1_id, 2, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @region_seq;

set @page_1_region_3 = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @region_seq);
INSERT INTO region(entity_id, page_id, render_order, locked)
values (@page_1_region_3, @page_1_id, 3, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @region_seq;
-- End --

-- Page 2 --
set @page_2_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_seq);
INSERT INTO page (entity_id, name, owner_id, parent_page_id, page_layout_id, page_type)
values (@page_2_id, 'Activity Stream', @user_id_1, null, @activity_stream_id, 'USER');
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_seq;

set @page_user_id =(SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_user_seq);
insert into page_user (entity_id, page_id, user_id, editor, render_sequence, page_status)
values (@page_user_id, @page_2_id, @user_id_1, true, 1, 'OWNER');
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_user_seq;

set @page_2_region_1 = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @region_seq);
INSERT INTO region(entity_id, page_id, render_order, locked)
values (@page_2_region_1, @page_2_id, 1, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @region_seq;

set @next_region_widget = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @region_widget_seq);
INSERT INTO region_widget(entity_id, widget_id, region_id, render_order, collapsed, locked, hide_chrome)
values (@next_region_widget, @activity_stream_gadget_id, @page_2_region_1, 0, FALSE, TRUE, TRUE);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @region_widget_seq;
-- End --

set @user_authority_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @granted_authority_seq);
insert into granted_authority (entity_id, authority, default_for_new_user)
values (@user_authority_id, 'ROLE_USER', true);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @granted_authority_seq;

set @admin_authority_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @granted_authority_seq);
insert into granted_authority (entity_id, authority, default_for_new_user)
values (@admin_authority_id, 'ROLE_ADMIN', false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @granted_authority_seq;

insert into user_authorities (user_id, authority_id)
values (@user_id_1, @admin_authority_id);

set @next_portal_preference_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @portal_preference_seq);
INSERT INTO portal_preference (entity_id, preference_key)
values (@next_portal_preference_id, 'titleSuffix');
INSERT INTO portal_preference_values
values (@next_portal_preference_id, ' - OpenSocial');
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @portal_preference_seq;

set @next_portal_preference_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @portal_preference_seq);
INSERT INTO portal_preference (entity_id, preference_key)
values (@next_portal_preference_id, 'pageSize');
INSERT INTO portal_preference_values
values (@next_portal_preference_id, '10');
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @portal_preference_seq;

set @next_portal_preference_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @portal_preference_seq);
INSERT INTO portal_preference (entity_id, preference_key)
values (@next_portal_preference_id, 'javaScriptDebugMode');
INSERT INTO portal_preference_values
values (@next_portal_preference_id, '0');
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @portal_preference_seq;

set @person_profile_page_template_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_template_seq);
insert into page_template (entity_id, page_type, page_layout_id, name, description, parent_page_template_id, render_sequence, default_template)
values (@person_profile_page_template_id, 'PERSON_PROFILE', @person_profile_layout_id, 'Person Profile', 'Template for person profile pages', null, 0, true);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_template_seq;

set @person_profile_page_template_region_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_template_region_seq);
insert into page_template_region (entity_id, render_sequence, page_template_id, locked)
values (@person_profile_page_template_region_id, 0, @person_profile_page_template_id, true);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_template_region_seq;

set @next_person_profile_page_template_widget_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_template_widget_seq);
insert into page_template_widget (entity_id, page_template_region_id, render_sequence, widget_id, locked, hide_chrome)
values (@next_person_profile_page_template_widget_id, @person_profile_page_template_region_id, 0, @my_groups_widget_id, true, true);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_template_widget_seq;

set @next_person_profile_page_template_widget_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_template_widget_seq);
insert into page_template_widget (entity_id, page_template_region_id, render_sequence, widget_id, locked, hide_chrome)
values (@next_person_profile_page_template_widget_id, @person_profile_page_template_region_id, 1, @my_experience_widget_id, true, true);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_template_widget_seq;


set @person_profile_subpage1_template_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_template_seq);
insert into page_template (entity_id, page_type, page_layout_id, name, description, parent_page_template_id, render_sequence, default_template)
values (@person_profile_subpage1_template_id, 'SUB_PAGE', @one_col_id, 'About', 'Template for the About sub page for the person profile', @person_profile_page_template_id, 0, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_template_seq;


set @person_profile_subpage1_template_region_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_template_region_seq);
insert into page_template_region (entity_id, render_sequence, page_template_id, locked)
values (@person_profile_subpage1_template_region_id, 0, @person_profile_subpage1_template_id, true);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_template_region_seq;

set @next_person_profile_subpage1_template_widget_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_template_widget_seq);
insert into page_template_widget (entity_id, page_template_region_id, render_sequence, widget_id, locked, hide_chrome)
values (@next_person_profile_subpage1_template_widget_id, @person_profile_subpage1_template_region_id, 0, @favorite_websites_widget_id, true, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_template_widget_seq;

set @next_person_profile_subpage1_template_widget_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_template_widget_seq);
insert into page_template_widget (entity_id, page_template_region_id, render_sequence, widget_id, locked, hide_chrome)
values (@next_person_profile_subpage1_template_widget_id, @person_profile_subpage1_template_region_id, 1, @schedule_widget_id, true, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_template_widget_seq;

set @person_profile_subpage2_template_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_template_seq);
insert into page_template (entity_id, page_type, page_layout_id, name, description, parent_page_template_id, render_sequence, default_template)
values (@person_profile_subpage2_template_id, 'SUB_PAGE', @one_col_id, 'My Activity', 'Template for the My Activity sub page for the person profile', @person_profile_page_template_id, 1, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_template_seq;

set @person_profile_subpage2_template_region_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_template_region_seq);
insert into page_template_region (entity_id, render_sequence, page_template_id, locked)
values (@person_profile_subpage2_template_region_id, 0, @person_profile_subpage2_template_id, true);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_template_region_seq;

set @next_person_profile_subpage2_template_widget_id = (SELECT seq_count FROM RAVE_PORTAL_SEQUENCES WHERE seq_name = @page_template_widget_seq);
insert into page_template_widget (entity_id, page_template_region_id, render_sequence, widget_id, locked, hide_chrome)
values (@next_person_profile_subpage2_template_widget_id, @person_profile_subpage2_template_region_id, 0, @my_activity_widget_id, true, false);
UPDATE RAVE_PORTAL_SEQUENCES SET seq_count = (seq_count + 1) WHERE seq_name = @page_template_widget_seq;
