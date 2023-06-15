import java.util.Arrays;
import java.util.List;

import java.lang.*;
import java.util.*;
import java.io.*;

    import javax.mail.*;
    import javax.mail.internet.*;
    import javax.activation.*;

public class work_stuff {

    public static void main(String[] args) {
        String str = "One hundred two thousand and thirty four";  //"One hundred two thousand and thirty four";
        long num;
        WordToNumber v_method = new WordToNumber();
        num = v_method.word_to_number(str);
        System.out.println(num);
    }
    public long word_to_number(String input){

    boolean isValidInput = true;
    long result = 0;
    long finalResult = 0;
    List<String> allowedStrings = Arrays.asList
    (
    "zero","one","two","three","four","five","six","seven",
    "eight","nine","ten","eleven","twelve","thirteen","fourteen",
    "fifteen","sixteen","seventeen","eighteen","nineteen","twenty",
    "thirty","forty","fifty","sixty","seventy","eighty","ninety",
    "hundred","thousand","million","billion","trillion"
    );


    if(input != null && input.length()> 0)
    {
        input = input.replaceAll("-", " ");
        input = input.toLowerCase().replaceAll(" and", " ");
        String[] splittedParts = input.trim().split("\\s+");

        for(String str : splittedParts)
        {
            if(!allowedStrings.contains(str))
            {
                isValidInput = false;
                System.out.println("Invalid word found : "+str);
                break;
            }
        }
        if(isValidInput)
        {
            for(String str : splittedParts)
            {
                if(str.equalsIgnoreCase("zero")) {
                    result += 0;
                }
                else if(str.equalsIgnoreCase("one")) {
                    result += 1;
                }
                else if(str.equalsIgnoreCase("two")) {
                    result += 2;
                }
                else if(str.equalsIgnoreCase("three")) {
                    result += 3;
                }
                else if(str.equalsIgnoreCase("four")) {
                    result += 4;
                }
                else if(str.equalsIgnoreCase("five")) {
                    result += 5;
                }
                else if(str.equalsIgnoreCase("six")) {
                    result += 6;
                }
                else if(str.equalsIgnoreCase("seven")) {
                    result += 7;
                }
                else if(str.equalsIgnoreCase("eight")) {
                    result += 8;
                }
                else if(str.equalsIgnoreCase("nine")) {
                    result += 9;
                }
                else if(str.equalsIgnoreCase("ten")) {
                    result += 10;
                }
                else if(str.equalsIgnoreCase("eleven")) {
                    result += 11;
                }
                else if(str.equalsIgnoreCase("twelve")) {
                    result += 12;
                }
                else if(str.equalsIgnoreCase("thirteen")) {
                    result += 13;
                }
                else if(str.equalsIgnoreCase("fourteen")) {
                    result += 14;
                }
                else if(str.equalsIgnoreCase("fifteen")) {
                    result += 15;
                }
                else if(str.equalsIgnoreCase("sixteen")) {
                    result += 16;
                }
                else if(str.equalsIgnoreCase("seventeen")) {
                    result += 17;
                }
                else if(str.equalsIgnoreCase("eighteen")) {
                    result += 18;
                }
                else if(str.equalsIgnoreCase("nineteen")) {
                    result += 19;
                }
                else if(str.equalsIgnoreCase("twenty")) {
                    result += 20;
                }
                else if(str.equalsIgnoreCase("thirty")) {
                    result += 30;
                }
                else if(str.equalsIgnoreCase("forty")) {
                    result += 40;
                }
                else if(str.equalsIgnoreCase("fifty")) {
                    result += 50;
                }
                else if(str.equalsIgnoreCase("sixty")) {
                    result += 60;
                }
                else if(str.equalsIgnoreCase("seventy")) {
                    result += 70;
                }
                else if(str.equalsIgnoreCase("eighty")) {
                    result += 80;
                }
                else if(str.equalsIgnoreCase("ninety")) {
                    result += 90;
                }
                else if(str.equalsIgnoreCase("hundred")) {
                    result *= 100;
                }
                else if(str.equalsIgnoreCase("thousand")) {
                    result *= 1000;
                    finalResult += result;
                    result=0;
                }
                else if(str.equalsIgnoreCase("million")) {
                    result *= 1000000;
                    finalResult += result;
                    result=0;
                }
                else if(str.equalsIgnoreCase("billion")) {
                    result *= 1000000000;
                    finalResult += result;
                    result=0;
                }
                else if(str.equalsIgnoreCase("trillion")) {
                    result *= 1000000000000L;
                    finalResult += result;
                    result=0;
                }
            }

            finalResult += result;
            result=0;
            //System.out.println(finalResult);
            return finalResult;
        }
    }
    return finalResult;
}
public long word_to_number_adverb(String input){
        
    boolean isValidInput = true;
    long result = 0;
    long finalResult = 0;
    List<String> allowedStrings = Arrays.asList
    (
    "zeroth","first","second","third","fourth","fifth","sixth","seventh",
    "eighth","nineth","tenth","eleventh","twelveth","thirteenth","fourteenth",
    "fifteenth","sixteenth","seventeenth","eighteenth","nineteenth","twentyth",
    "thirtyth","fortyth","fiftyth","sixtyth","seventyth","eightyth","ninetyth",
    "hundredth","thousandth","millionth","billionth","trillionth"
    );


    if(input != null && input.length()> 0)
    {
        input = input.replaceAll("-", " ");
        input = input.toLowerCase().replaceAll(" and", " ");
        String[] splittedParts = input.trim().split("\\s+");

        for(String str : splittedParts)
        {
            if(!allowedStrings.contains(str))
            {
                isValidInput = false;
                System.out.println("Invalid word found : "+str);
                break;
            }
        }
        if(isValidInput)
        {
            for(String str : splittedParts)
            {
                if(str.equalsIgnoreCase("zeroth")) {
                    result += 0;
                }
                else if(str.equalsIgnoreCase("first")) {
                    result += 1;
                }
                else if(str.equalsIgnoreCase("second")) {
                    result += 2;
                }
                else if(str.equalsIgnoreCase("third")) {
                    result += 3;
                }
                else if(str.equalsIgnoreCase("fourth")) {
                    result += 4;
                }
                else if(str.equalsIgnoreCase("fifth")) {
                    result += 5;
                }
                else if(str.equalsIgnoreCase("sixth")) {
                    result += 6;
                }
                else if(str.equalsIgnoreCase("seventh")) {
                    result += 7;
                }
                else if(str.equalsIgnoreCase("eighth")) {
                    result += 8;
                }
                else if(str.equalsIgnoreCase("nineth")) {
                    result += 9;
                }
                else if(str.equalsIgnoreCase("tenth")) {
                    result += 10;
                }
                else if(str.equalsIgnoreCase("eleventh")) {
                    result += 11;
                }
                else if(str.equalsIgnoreCase("twelveth")) {
                    result += 12;
                }
                else if(str.equalsIgnoreCase("thirteenth")) {
                    result += 13;
                }
                else if(str.equalsIgnoreCase("fourteenth")) {
                    result += 14;
                }
                else if(str.equalsIgnoreCase("fifteenth")) {
                    result += 15;
                }
                else if(str.equalsIgnoreCase("sixteenth")) {
                    result += 16;
                }
                else if(str.equalsIgnoreCase("seventeenth")) {
                    result += 17;
                }
                else if(str.equalsIgnoreCase("eighteenth")) {
                    result += 18;
                }
                else if(str.equalsIgnoreCase("nineteenth")) {
                    result += 19;
                }
                else if(str.equalsIgnoreCase("twentyth")) {
                    result += 20;
                }
                else if(str.equalsIgnoreCase("thirtyth")) {
                    result += 30;
                }
                else if(str.equalsIgnoreCase("fortyth")) {
                    result += 40;
                }
                else if(str.equalsIgnoreCase("fiftyth")) {
                    result += 50;
                }
                else if(str.equalsIgnoreCase("sixtyth")) {
                    result += 60;
                }
                else if(str.equalsIgnoreCase("seventyth")) {
                    result += 70;
                }
                else if(str.equalsIgnoreCase("eightyth")) {
                    result += 80;
                }
                else if(str.equalsIgnoreCase("ninetyth")) {
                    result += 90;
                }
                else if(str.equalsIgnoreCase("hundredth")) {
                    result *= 100;
                }
                else if(str.equalsIgnoreCase("thousandth")) {
                    result *= 1000;
                    finalResult += result;
                    result=0;
                }
                else if(str.equalsIgnoreCase("millionth")) {
                    result *= 1000000;
                    finalResult += result;
                    result=0;
                }
                else if(str.equalsIgnoreCase("billionth")) {
                    result *= 1000000000;
                    finalResult += result;
                    result=0;
                }
                else if(str.equalsIgnoreCase("trillionth")) {
                    result *= 1000000000000L;
                    finalResult += result;
                    result=0;
                }
            }

            finalResult += result;
            result=0;
            //System.out.println(finalResult);
            return finalResult;
        }
    }
    return finalResult;
}

public static String directory_list(String path) {
    try {
      String list = "";
      File myFile = new File(path);
      String[] arrayList = myFile.list();

      Arrays.sort(arrayList, String.CASE_INSENSITIVE_ORDER);

      for (int i = 0; i < arrayList.length; i++) {
        // Prevent directory listing expanding if we will blow VARCHAR2 limit.
        if ((list.length() + arrayList[i].length() + 1) > 19980)
          break;

        if (!list.equals(""))
          list += ",\n" + arrayList[i];
        else
          list += arrayList[i];
      }
      return list;
    } catch (Exception e) {
      return "Path not found";
    }
  }
  public static String directory_list_2(String path) {
    try {
      String list = "";
      String list_2 = "";
      File myFile = new File(path);
      String[] arrayList = myFile.list();
      int size = 0;

      Arrays.sort(arrayList, String.CASE_INSENSITIVE_ORDER);

      for (int i = 0; i < arrayList.length; i++) {
        // Prevent directory listing expanding if we will blow VARCHAR2 limit.
        // maximum length for VARCHAR2 is 32672 BYTE or 8168 CHAR
        size = size + list.getBytes().length;
        if ((list.length() + arrayList[i].length() + 1) > 19980) {// (list.length() + arrayList[i].length() + 1)
          //break;
          if (!list_2.equals("")){
          list_2 += ",\n" + arrayList[i];}
           else{
            list_2 += arrayList[i];}
               if ((list.length() + arrayList[i].length() + 1) > 39960){
               break;
        }

        }
        if (!list.equals(""))
          list += ",\n" + arrayList[i];
        else
          list += arrayList[i];
      }

      return list_2;
    } catch (Exception e) {
      return "Path not found";
    }
  }
    public static String directory_list_sl(String path) {
    try {
      String list = "";
      File myFile = new File(path);
      String[] arrayList = myFile.list();
      int size = 0;

      Arrays.sort(arrayList, String.CASE_INSENSITIVE_ORDER);

      for (int i = 0; i < arrayList.length; i++) {
        // Prevent directory listing expanding if we will blow VARCHAR2 limit.
        // maximum length for VARCHAR2 is 32672 BYTE or 8168 CHAR
        size = size + list.getBytes().length;
        if ((list.length() + arrayList[i].length() + 1) > 18000) // (list.length() + arrayList[i].length() + 1)
          break;

        if (!list.equals(""))
          list += ", " + arrayList[i];
        else
          list += arrayList[i];
      }

      return list;
    } catch (Exception e) {
      return "Path not found";
    }
  }
  public static String directory_list_sl_2(String path) {
    try {
      String list = "";
      String list_2 = "";
      File myFile = new File(path);
      String[] arrayList = myFile.list();
      int size = 0;

      Arrays.sort(arrayList, String.CASE_INSENSITIVE_ORDER);

      for (int i = 0; i < arrayList.length; i++) {
        // Prevent directory listing expanding if we will blow VARCHAR2 limit.
        // maximum length for VARCHAR2 is 32672 BYTE or 8168 CHAR
        size = size + list.getBytes().length;
        if ((list.length() + arrayList[i].length() + 1) > 18000) {// (list.length() + arrayList[i].length() + 1)
          //break;
          if (!list_2.equals("")){
          list_2 += ", " + arrayList[i];}
           else{
            list_2 += arrayList[i];}
               if ((list.length() + arrayList[i].length() + 1) > 36000){
               break;
        }

        }
        if (!list.equals(""))
          list += ", " + arrayList[i];
        else
          list += arrayList[i];
      }

      return list_2;
    } catch (Exception e) {
      return "Path not found";
    }
  }

  // Sender, Recipient, CCRecipient, and BccRecipient are comma-
    // separated lists of addresses;
    // Body can span multiple CR/LF-separated lines;
    // Attachments is a ///-separated list of file names;
    public static int Send(String SMTPServer,
                                  String Sender,
                           String Recipient,
                           String CcRecipient,
                           String BccRecipient,
                           String Subject,
                           String Body,
                           String ErrorMessage[],
                           String Attachments) {
    // Error status;
    int ErrorStatus = 0;
    // create some properties and get the default Session;
    Properties props = System.getProperties();
    props.put("mail.smtp.host", SMTPServer);
    props.put("mail.smtp.port", "25251");
    Session session = Session.getDefaultInstance(props, null);
     try {
      // create a message;
      MimeMessage msg = new MimeMessage(session);
      // extracts the senders and adds them to the message;
      // Sender is a comma-separated list of e-mail addresses as
      // per RFC822;
       {
        InternetAddress[] TheAddresses =
        InternetAddress.parse(Sender);
        msg.addFrom(TheAddresses);
        }
   // extract the recipients and assign them to the message;
   // Recipient is a comma-separated list of e-mail addresses
   // as per RFC822;
     {
        InternetAddress[] TheAddresses =
        InternetAddress.parse(Recipient);
        msg.addRecipients(Message.RecipientType.TO,
        TheAddresses);
        }
   // extract the Cc-recipients and assign them to the
   // message;
   // CcRecipient is a comma-separated list of e-mail
   // addresses as per RFC822;
   if (null != CcRecipient) {
     InternetAddress[] TheAddresses =
     InternetAddress.parse(CcRecipient);
     msg.addRecipients(Message.RecipientType.CC, TheAddresses);
                              }
  // extract the Bcc-recipients and assign them to the
  // message;
  // BccRecipient is a comma-separated list of e-mail
  // addresses as per RFC822;
    if (null != BccRecipient) {
        InternetAddress[] TheAddresses =
        InternetAddress.parse(BccRecipient);
        msg.addRecipients(Message.RecipientType.BCC,
        TheAddresses);
                                   }
   // subject field;
   msg.setSubject(Subject);
   // create the Multipart to be added the parts to;
   Multipart mp = new MimeMultipart();
   // create and fill the first message part;
     {
        MimeBodyPart mbp = new MimeBodyPart();
        mbp.setContent(Body, "text/html; charset=utf-8"); // mbp.setText(Body); //to not have html
        // attach the part to the multipart;
        mp.addBodyPart(mbp);
      }
   // attach the files to the message;
  if (null != Attachments) {
       int StartIndex = 0, PosIndex = 0;
      while (-1 != (PosIndex = Attachments.indexOf("///",
       StartIndex))) {
       // create and fill other message parts;
       MimeBodyPart mbp = new MimeBodyPart();
       FileDataSource fds =
       new FileDataSource(Attachments.substring(StartIndex, PosIndex));
       mbp.setDataHandler(new DataHandler(fds));
       mbp.setFileName(fds.getName());
        mp.addBodyPart(mbp);
       PosIndex += 3;
       StartIndex = PosIndex;
                      }
  // last, or only, attachment file;
  if (StartIndex < Attachments.length()) {
       MimeBodyPart mbp = new MimeBodyPart();
     FileDataSource fds =
     new FileDataSource(Attachments.substring(StartIndex));
     mbp.setDataHandler(new DataHandler(fds));
     mbp.setFileName(fds.getName());
     mp.addBodyPart(mbp);
                     }
          }
    // add the Multipart to the message;
    msg.setContent(mp);
    // set the Date: header;
    msg.setSentDate(new Date());
    // send the message;
    Transport.send(msg);
   }
   catch (MessagingException MsgException) {
     ErrorMessage[0] = MsgException.toString();
     Exception TheException = null;
     if ((TheException = MsgException.getNextException()) != null)
       ErrorMessage[0] = ErrorMessage[0] + "\n" +
       TheException.toString();
       ErrorStatus = 1;
                                           }
       return ErrorStatus;
       }

}