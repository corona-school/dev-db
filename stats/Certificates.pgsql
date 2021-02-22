SELECT 
    COUNT(*) as "manual_certificates" 
  FROM participation_certificate 
  WHERE "state" = 'manual' OR "state" IS NULL;

SELECT 
    COUNT(*) as "pending_certificates" 
  FROM participation_certificate 
  WHERE "state" = 'awaiting-approval';

SELECT 
    COUNT(*)                 as "automatic_certificates",
    COUNT("signaturePupil")  as  "by_pupil",
    COUNT("signatureParent") as "by_parent"
  FROM participation_certificate 
  WHERE "state" = 'approved';
