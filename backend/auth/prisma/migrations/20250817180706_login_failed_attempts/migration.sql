-- AlterTable
ALTER TABLE "public"."UserDetails" ADD COLUMN     "lastFailedLoginAt" TIMESTAMP(3),
ADD COLUMN     "lockUntil" TIMESTAMP(3);
