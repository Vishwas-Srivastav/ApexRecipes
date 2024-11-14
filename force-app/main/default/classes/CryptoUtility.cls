/**
 * @description Encryption/Decryption utility leveraging Apex Crypto class AES128/AES256 keys, HMAC generation, and SHA-256 hashing.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
public with sharing class CryptoUtility {

    /**
     * @description Generates SHA-256 hash string from input data.
     * @param input Plain text input string.
     * @return String Hex-encoded SHA-256 hash string.
     */
    public static String generateSha256Hash(String input) {
        if (String.isBlank(input)) {
            return null;
        }
        Blob inputBlob = Blob.valueOf(input);
        Blob hashBlob = Crypto.generateDigest('SHA-256', inputBlob);
        return EncodingUtil.convertToHex(hashBlob);
    }

    /**
     * @description Encrypts plain text using AES128 symmetric encryption.
     * @param clearText Plain text to encrypt.
     * @param secretKey 128-bit key Blob.
     * @return Blob Encrypted cipher blob.
     */
    public static Blob encryptAes128(String clearText, Blob secretKey) {
        if (String.isBlank(clearText) || secretKey == null) {
            return null;
        }
        return Crypto.encryptWithManagedIV('AES128', secretKey, Blob.valueOf(clearText));
    }

    /**
     * @description Decrypts cipher Blob using AES128 symmetric encryption.
     * @param cipherText Encrypted Blob.
     * @param secretKey 128-bit key Blob.
     * @return String Decrypted clear text string.
     */
    public static String decryptAes128(Blob cipherText, Blob secretKey) {
        if (cipherText == null || secretKey == null) {
            return null;
        }
        Blob decryptedBlob = Crypto.decryptWithManagedIV('AES128', secretKey, cipherText);
        return decryptedBlob.toString();
    }
}
