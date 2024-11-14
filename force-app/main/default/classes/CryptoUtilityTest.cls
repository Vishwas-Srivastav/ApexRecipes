/**
 * @description Unit tests for CryptoUtility.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
@IsTest
private class CryptoUtilityTest {

    @IsTest
    static void testSha256Hash() {
        String hash = CryptoUtility.generateSha256Hash('ApexRecipesTestPayload');
        Assert.isNotNull(hash, 'Hash result should not be null');
        Assert.areEqual(64, hash.length(), 'SHA-256 hex string should be 64 characters long');
    }

    @IsTest
    static void testAes128EncryptionDecryption() {
        String clearText = 'SecretDataToEncrypt';
        Blob key = Crypto.generateAesKey(128);

        Blob cipherBlob = CryptoUtility.encryptAes128(clearText, key);
        Assert.isNotNull(cipherBlob, 'Encrypted cipher blob should not be null');

        String decryptedText = CryptoUtility.decryptAes128(cipherBlob, key);
        Assert.areEqual(clearText, decryptedText, 'Decrypted text should match original clear text');
    }
}
