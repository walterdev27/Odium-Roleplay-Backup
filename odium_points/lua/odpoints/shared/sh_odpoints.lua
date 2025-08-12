local pMeta = FindMetaTable( "Player" )

function pMeta:GetOdpoints()
    return self:GetNWInt('odpoints',0)
end

print(" en sah joey ....")