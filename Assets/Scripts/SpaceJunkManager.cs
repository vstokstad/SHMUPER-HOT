using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class SpaceJunkManager : MonoBehaviour {
    private List<GameObject> _spaceJunkList;
    private readonly int _numberOfSpaceJunk = 20;
    private float _spawnTimer = 4f;
    private readonly string _spaceJunkPath = "SpaceJunk";
  
    void Awake()
    {
        _spaceJunkList = new List<GameObject>(_numberOfSpaceJunk);
        for (int i = 0; i < _numberOfSpaceJunk; i++) {
           _spaceJunkList.Add(Instantiate(Resources.Load(_spaceJunkPath, typeof(GameObject))) as GameObject);
           _spaceJunkList[i].SetActive(false);
        }
        
    }
    
    void Update(){
        _spawnTimer -= Time.deltaTime;
        if (!(_spawnTimer <= 0f)) return;
        if (_spaceJunkList.Count <= 0) return;
        foreach (GameObject junk in _spaceJunkList.Where(junk => !junk.activeSelf)) {
            junk.gameObject.SetActive(true);
            break;
        }
    }
}
