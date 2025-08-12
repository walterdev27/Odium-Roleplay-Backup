function CheckStaff(ply)
    if !IsValid(ply) then return end

    if MyLib.StaffGeneralPrincipalePerm[ply:GetUserGroup()] then return true end
    if ply:IsSuperAdmin() then return true end

    return false 
end