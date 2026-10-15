use std/assert
use bf
use ../bf-freshrss/install.nu *


#======================================================================================================================
# credentials
#======================================================================================================================

export def credentials__documented_names__are_used [] {
    let result = with-env {BF_FR_USER_NAME: "ben", BF_FR_USER_PASS: "secret", BF_FR_USER: "old", BF_FR_PASS: "old"} { credentials }

    assert equal {user: "ben", pass: "secret"} $result
}

export def credentials__only_old_names__are_used_as_fallback [] {
    # the Dockerfile sets BF_FR_USER_NAME and BF_FR_USER_PASS to empty values
    let result = with-env {BF_FR_USER_NAME: "", BF_FR_USER_PASS: "", BF_FR_USER: "old", BF_FR_PASS: "older"} { credentials }

    assert equal {user: "old", pass: "older"} $result
}

export def credentials__not_set__returns_error_naming_documented_variable [] {
    let result = try { with-env {BF_FR_USER_NAME: ""} { credentials } ; "" } catch {|e| $e.msg }

    assert ($result | str contains "BF_FR_USER_NAME") $"the error should name BF_FR_USER_NAME, not: ($result)"
}


#======================================================================================================================
# complete / check
#======================================================================================================================

export def check__after_complete__returns_true [] {
    # complete stores the flag in the saved environment - start-up scripts load it before calling check
    let result = do --env { complete ; bf env load ; check }

    assert equal true $result
}
