using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class SearchAdd : MonoBehaviour
{
    private int random;

    [SerializeField] private string[] characters;
    [SerializeField] private TMP_InputField websiteinput;
    [SerializeField] private TMP_InputField emailinput;
    [SerializeField] private TMP_InputField passwordinput;

    Dictionary<string, string> dataemail = new Dictionary<string, string>();
    Dictionary<string, string> datapassword = new Dictionary<string, string>();


    public void onShowHideButtonClick()
    {
        if (passwordinput.contentType == TMP_InputField.ContentType.Password)
        {
            passwordinput.contentType = TMP_InputField.ContentType.Standard;
        }
        else
        {
            passwordinput.contentType = TMP_InputField.ContentType.Password;
        }
        passwordinput.ForceLabelUpdate();
    }


    public void onGenerateButtonClick()
    {
        string new_pass = "";

        for (int i = 0; i < 12; i++)
        {

            random = Random.Range(0, characters.Length);

            new_pass += characters[random];

            //Debug.Log(random);
        }
        passwordinput.text = new_pass;
    }


    public void AddButtonClicked()
    {
        dataemail.Add(websiteinput.text, emailinput.text);
        datapassword.Add(websiteinput.text, passwordinput.text);
    }


    public void SearchButtonClicked()
    {
        if (dataemail.ContainsKey(websiteinput.text))
        {
            emailinput.text = dataemail[websiteinput.text];
            passwordinput.text = datapassword[websiteinput.text];
        }

        else
        {
            Debug.Log("key does NOT exist");
        }
    }
}
