/*
 * Created on 2004-11-29
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

/**
 * @author Patryk Czarnik
 */
public class LiczbySAX {
    public static void main(String[] args) {
        if(args.length < 1) {
            System.out.println("Za malo parametrow");
            return;
        }

        try {
            SAXParserFactory factory = SAXParserFactory.newInstance();
            factory.setValidating(true);
            SAXParser parser = factory.newSAXParser();

            LiczbyHandler handler = new LiczbyHandler();
            parser.parse(args[0], handler);

           // System.out.println("Result: "+handler.getResult());
        } catch (FactoryConfigurationError e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SAXException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ParserConfigurationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    private static class LiczbyHandler extends DefaultHandler {
        enum Stan {ZEWN, GRUPA, GRUPA2, LICZBA, LICZBA2};

        ArrayList<Integer> fWyniki = new ArrayList<Integer>();
        private int fWynik;
        private Stan fStan = Stan.ZEWN;
        private StringBuffer fBuf;
        int flag=6;

        public int getResult() {
            return fWynik;
        }

        public void startElement(String uri, String localName, String qName,
                                 Attributes attributes) throws SAXException {
            if("grupa".equals(qName)) {
                String attrVal = attributes.getValue("wazne");
                if("tak".equals(attrVal)) {
                    fStan = Stan.GRUPA;
                    flag=0;
                    fWyniki.clear();
                }
                else if("nie".equals(attrVal)) {
                    fStan = Stan.GRUPA;
                    flag=1;
                    fWyniki.clear();
                }
            } else if("l".equals(qName)) {
                if(fStan == Stan.GRUPA) {
                    fStan = Stan.LICZBA;
                    fBuf = new StringBuffer();
                }
                else if(fStan == Stan.GRUPA){
                    fStan = Stan.LICZBA2;
                    fBuf = new StringBuffer();
                }
            }
        }

        public void endElement(String uri, String localName, String qName)
                throws SAXException {
            if("grupa".equals(qName)) {
                if(fStan == Stan.GRUPA && flag==1) {
                    fStan = Stan.ZEWN;
                    System.out.println("najwieksza wartosc w grupie = " + getResult());
                }
                else if(fStan == Stan.GRUPA && flag==0) {
                    fStan = Stan.ZEWN;
                    System.out.println("najmniejsza wartosc w grupie = " + getResult());
                }
            } else if("l".equals(qName)) {
                if(fStan == Stan.LICZBA ) {
                    fStan = Stan.GRUPA;
                    try {
                        fWyniki.add(Integer.parseInt(fBuf.toString()));
                        fWynik = Collections.min(fWyniki);
                    } catch (NumberFormatException e) {
                    }
                }
                else if (fStan == Stan.LICZBA ){
                    fStan = Stan.GRUPA;
                    try {
                        fWyniki.add(Integer.parseInt(fBuf.toString()));
                        System.out.println(fWyniki);
                        fWynik = Collections.max(fWyniki);
                    } catch (NumberFormatException e) {
                    }
                }
            }
        }
        public void characters(char[] ch, int start, int length)
                throws SAXException {
            if(fStan == Stan.LICZBA)
                fBuf.append(ch, start, length);
        }
    }
}
