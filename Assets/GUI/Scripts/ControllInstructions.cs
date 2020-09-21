
using UnityEngine;

public class ControllInstructions : MonoBehaviour
{
    private void Awake(){
        gameObject.SetActive(true);
    }

    private void OnGUI(){
        if (Input.anyKey) {
            gameObject.SetActive(false);
        }
        if (Input.GetKeyDown(KeyCode.I)) gameObject.SetActive(true);
    }
}
