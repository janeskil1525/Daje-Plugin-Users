package Daje::Helper::Users::LoadCompleteUser;
use Mojo::Base -base, -async_await;
use v5.42;

# NAME
# ====
#
# Daje::Helper::Users::LoadCompleteUser - Its a load user  helper
#
#
# DESCRIPTION
# ===========
#
#
#
# REQUIRES
# ========
#
# Daje::Helper::Users::LoadCompleteUser
#
#
# v5.42
#
# Mojo::Base
#
#
# METHODS
# =======
#
#
# LICENSE
# =======
#
# Copyright (C) janeskil1525.
#
# This library is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# AUTHOR
# ======
#
# janeskil1525 E<lt>janeskil1525@gmail.comE<gt>
#

has 'db';

async sub load_complete_user_p($self, $companies_pkey, $users_pkey, $users_users_pkey) {

    my $stmt = qq{
        SELECT users_users_pkey,
            companies_companies_fkey,
            users_workflow_fkey,
            avatar,
            avatarurl,
            name,
            mail,
            password,
            phone,
            biography,
            department,
            employed,
            position,
            officelocation,
            country,
            active,
            verified,
            city,
            zipcode,
            addressline1,
            addressline2,
            region,
            sendinvitation,
            notes,
            authorities_role_fkey,
            languages_lan_fkey
        FROM users_users, companies_users
            WHERE users_users_pkey = users_users_fkey  AND companies_companies_fkey = ? AND users_users_pkey = ?
    };

    my $load =  $self->db->query($stmt,($companies_pkey, $users_users_pkey));

    my $result->{data} = {};
    $result->{data} = $load->hash if $load and $load->rows > 0;
    $result->{result} = 1;

    return $result;
}
1;