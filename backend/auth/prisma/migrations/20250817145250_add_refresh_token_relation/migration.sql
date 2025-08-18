/*
  Warnings:

  - You are about to drop the column `refreshToken` on the `UserDetails` table. All the data in the column will be lost.
  - Added the required column `expiresAt` to the `RefreshToken` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."RefreshToken" ADD COLUMN     "expiresAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "public"."UserDetails" DROP COLUMN "refreshToken";
