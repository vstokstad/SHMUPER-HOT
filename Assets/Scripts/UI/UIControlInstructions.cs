using UnityEngine;

namespace UI {
    public class UIControlInstructions : MonoBehaviour {
        private void Awake(){
            gameObject.SetActive(true);
        }

        private void OnGUI(){
            if (Input.anyKey) gameObject.SetActive(false);
        }
    }
}